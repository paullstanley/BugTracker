//
//  StorageProvider.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/14/22.
//

import CoreData

public class PersistentContainer: NSPersistentContainer { }

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
 
    public func saveContext() {
        guard let context: NSManagedObjectContext = self.persistentContainer?.viewContext else { return }
        if context.hasChanges {
                try? context.save()
        }
    }
}
