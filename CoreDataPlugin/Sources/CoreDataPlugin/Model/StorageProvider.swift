//
//  StorageProvider.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/14/22.
//

import CoreData
import CloudKit

public class PersistentContainer: NSPersistentCloudKitContainer { }

public class StorageProvider {
   // public lazy var container = createContainer(inTheCloud: true)
    private var _privatePersistentStore: NSPersistentStore?
    private var _sharedPersistentStore: NSPersistentStore?
    
    public init() { }
    
    var ckContainer: CKContainer {
        let storeDescription = peristentContainer!.persistentStoreDescriptions.first
        guard let identifier = storeDescription?.cloudKitContainerOptions!.containerIdentifier else {
        fatalError("Unable to get container identifier")
      }
      return CKContainer(identifier: identifier)
    }

    var context: NSManagedObjectContext {
        peristentContainer!.viewContext
    }

    var privatePersistentStore: NSPersistentStore {
      guard let privateStore = _privatePersistentStore else {
        fatalError("Private store is not set")
      }
      return privateStore
    }

    var sharedPersistentStore: NSPersistentStore {
      guard let sharedStore = _sharedPersistentStore else {
        fatalError("Shared store is not set")
      }
      return sharedStore
    }
    
    lazy public var peristentContainer: PersistentContainer? = {
        guard let modelURL: URL = Bundle.module.url(forResource:"IssueTrackingSystem", withExtension: "momd") else {
            fatalError()
        }
        guard let model: NSManagedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError()
        }
        
        let container = PersistentContainer(name: "IssueTrackingSystem", managedObjectModel: model)
        
        guard let privateStoreDescription = container.persistentStoreDescriptions.first else {
            fatalError("Unable to get privateStoreDescription")
        }
        
        let storesURL = privateStoreDescription.url?.deletingLastPathComponent()
        privateStoreDescription.url = storesURL?.appendingPathComponent("private.sqlite")
        let sharedStoreURL = storesURL?.appendingPathComponent("shared.sqlite")
        guard let sharedDescription = privateStoreDescription.copy() as? NSPersistentStoreDescription else {
            fatalError("Copying the private store description returned an unexpected value.")
        }
        sharedDescription.url = sharedStoreURL
        
        guard let containerIdentifier = privateStoreDescription.cloudKitContainerOptions?.containerIdentifier else {
            fatalError("Unable to get containerIdentifier")
        }
        let sharedStoreOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: containerIdentifier)
        sharedStoreOptions.databaseScope = .shared
        sharedDescription.cloudKitContainerOptions = sharedStoreOptions
        container.persistentStoreDescriptions.append(sharedDescription)
        
        container.loadPersistentStores { loadedStoreDescription, error in
            if let error = error as NSError? {
                fatalError("Failed to load the persistent stores: \(error)")
            } else if let cloudKitContainerOptions = loadedStoreDescription.cloudKitContainerOptions {
                guard let loadedStoreDescriptionURL = loadedStoreDescription.url else {
                    return
                }
                
                if cloudKitContainerOptions.databaseScope == .private {
                    let privateStore = container.persistentStoreCoordinator.persistentStore(for: loadedStoreDescriptionURL)
                    self._privatePersistentStore = privateStore
                } else if cloudKitContainerOptions.databaseScope == .shared {
                    let sharedStore = container.persistentStoreCoordinator.persistentStore(for: loadedStoreDescriptionURL)
                    self._sharedPersistentStore = sharedStore
                }
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
        do {
            try container.viewContext.setQueryGenerationFrom(.current)
        } catch {
            fatalError("Failed to pin the viewContext to the current deneration: \(error)")
        }
        return container
    }()
 
    public func saveContext() {
        guard let context: NSManagedObjectContext = self.peristentContainer?.viewContext else { return }
        if context.hasChanges {
                try? context.save()
        }
    }
}
