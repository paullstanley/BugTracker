//
//  StorageProvider.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/14/22.
//

import CoreData
import CloudKit

public class PersistentContainer: NSPersistentContainer { }

public class PersistentCloudKitContainer: NSPersistentCloudKitContainer { }

public class StorageProvider {
    public lazy var container = createContainer(inTheCloud: true)
    
    public init() { }

    lazy public var persistentContainer: PersistentContainer? = {
        guard let modelURL: URL = Bundle.module.url(forResource:"IssueTrackingSystem", withExtension: "momd") else { return  nil }
        guard let model: NSManagedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else { return nil }
        let container: PersistentContainer = PersistentContainer(name:"DataBase",managedObjectModel:model)
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    print("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
    
    lazy public var peristentCloudKitContainer: PersistentCloudKitContainer? = {
        guard let modelURL: URL = Bundle.module.url(forResource:"IssueTrackingSystem", withExtension: "momd") else { return  nil }
        guard let model: NSManagedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else { return nil }
        
        let id = "group.com.paullo.IssueTrackingSystem"
        let container = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: id)!
        let url = container.appendingPathComponent("DataBase.sqlite")
        
        let cloudKitContainer = PersistentCloudKitContainer(name: "IssueTrackingSystem", managedObjectModel: model)
        cloudKitContainer.persistentStoreDescriptions.first!.url = url
        
        cloudKitContainer.persistentStoreDescriptions.first!.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        cloudKitContainer.persistentStoreDescriptions.first!.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        cloudKitContainer.loadPersistentStores(completionHandler: {
            description, error in
            if let error = error {
                fatalError("Core Data Store failed to load with the error: \(error)")
            }
        })
        return cloudKitContainer
    }()
    
    lazy var persistentSharedContainer: NSPersistentCloudKitContainer? = {
        guard let modelURL: URL = Bundle.module.url(forResource:"IssueTrackingSystem", withExtension: "momd") else { return  nil}
        guard let model: NSManagedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else { return nil }
        
        let persistentContainer = PersistentCloudKitContainer(name: "IssueTrackingSystem", managedObjectModel: model)
        let defaultSqliteLocation = PersistentCloudKitContainer.defaultDirectoryURL()
        let localStoreURL = defaultSqliteLocation.appendingPathComponent("Local.sqlite")
        let localDescription = NSPersistentStoreDescription(url: localStoreURL)
        localDescription.configuration = "Local"
        
        let syncedStoreURL =  defaultSqliteLocation.appending(path: "Synced.sqlite")
        let syncedDescription = NSPersistentStoreDescription(url: syncedStoreURL)
        syncedDescription.configuration = "Synced"
        
        syncedDescription.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.paullo.IssueTrackingSystem")
        syncedDescription.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        syncedDescription.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        
        persistentContainer.persistentStoreDescriptions = [localDescription, syncedDescription]
        
        persistentContainer.loadPersistentStores(completionHandler: { description, error in
            if let error = error {
                fatalError("Unable to load persistent container \(error.localizedDescription)")
            }
        })
        
        
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return persistentContainer
    }()
    
    private func createContainer(inTheCloud: Bool)-> NSPersistentContainer? {
        if inTheCloud {
            return persistentSharedContainer
        } else {
            return persistentContainer
        }
    }
 
    public func saveContext() {
        guard let context: NSManagedObjectContext = self.persistentContainer?.viewContext else { return }
        if context.hasChanges {
                try? context.save()
        }
    }
    
    private var _sharedPersistentStore: NSPersistentStore?
    var sharedPersistentStore: NSPersistentStore {
        return _sharedPersistentStore!
    }
    
    lazy var cloudKitContainer: CKContainer = {
        return CKContainer(identifier: gCloudKitContainerIdentifier)
    }()

    lazy var historyQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}
