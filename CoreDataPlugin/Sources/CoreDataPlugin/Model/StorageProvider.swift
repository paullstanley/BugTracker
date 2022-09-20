//
//  StorageProvider.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/14/22.
//

import CoreData

public class PersistentContainer: NSPersistentContainer { }

public class PersistentCloudKitContainer: NSPersistentCloudKitContainer { }

public class StorageProvider {
    
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
        print("!!!!!!!!!")
        print(url)
        
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
 
    public func saveContext() {
        guard let context: NSManagedObjectContext = self.persistentContainer?.viewContext else { return }
        if context.hasChanges {
                try? context.save()
        }
    }
}
