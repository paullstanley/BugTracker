//
//  PersistentHistoryTracker.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/14/22.
//

import CoreData

class PersistentHistoryTracker {
    private let persistentContainer: NSPersistentContainer
    private let actor: StorageActor
    
    init(_persistentContainer: NSPersistentContainer, _actor: StorageActor) {
        self.persistentContainer = _persistentContainer
        self.actor = _actor
        
            NotificationCenter.default.addObserver(self, selector: #selector(processChanges), name: .NSPersistentStoreRemoteChange, object: persistentContainer.persistentStoreCoordinator)
    }
    
    func lastUpdated()-> Date? {
        return UserDefaults.shared.object(forKey: "PersistentHistoryTracker.lastUpdate") as? Date
    }
    
    func persistLastUpdated(_ date: Date) {
      return UserDefaults.shared.set(date, forKey: "PersistentHistoryTracker.lastUpdate")
    }

    func leasRecentUpdate()-> Date? {
        return StorageActor.allCases.reduce(nil) { currentLeastRecent, actor in
            guard let updateDate: Date = UserDefaults.shared.object(forKey: "PersistentHistoryTracker.lastUpdate") as? Date else { return currentLeastRecent }
            
            if let oldDate: Date = currentLeastRecent {
                return min(oldDate, updateDate)
            }
            return updateDate
        }
    }
    @objc public func processChanges() {
        let lastDate: Date = self.lastUpdated() ?? .distantPast
        let request: NSPersistentHistoryChangeRequest = NSPersistentHistoryChangeRequest.fetchHistory(after: lastDate)
        
        let context: NSManagedObjectContext = persistentContainer.viewContext
        
        context.perform { [unowned self] in
            do {
                guard let result = try context.execute(request) as? NSPersistentHistoryResult,
                      let history = result.result as? [NSPersistentHistoryTransaction],
                      !history.isEmpty else {
                    return
                }
                
                for transaction in history {
                    let notification: Notification =  transaction.objectIDNotification()
                    context.mergeChanges(fromContextDidSave: notification)
                    
                    self.persistLastUpdated(transaction.timestamp)
                }
                
                if let lastTimestamp = leasRecentUpdate() {
                    let deleteRequest: NSPersistentHistoryChangeRequest = NSPersistentHistoryChangeRequest.deleteHistory(before: lastTimestamp)
                    try context.execute(deleteRequest)
                }
            } catch {
                print(error)
            }
        }
    }
}
public enum StorageActor: String, CaseIterable {
    case swifuiApp
}
