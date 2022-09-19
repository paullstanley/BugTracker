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
            guard let modelURL = Bundle.module.url(forResource:"IssueTrackingSystem", withExtension: "momd") else { return  nil }
            guard let model = NSManagedObjectModel(contentsOf: modelURL) else { return nil }
            let container = PersistentContainer(name:"DataBase",managedObjectModel:model)
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    print("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
 
    public func saveContext() {
        let context = self.persistentContainer?.viewContext
        if context!.hasChanges {
                try? context?.save()
        }
    }
}
