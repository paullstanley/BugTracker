//
//  StorageProvider.swift
//  IssueTrackingSystem
//
//  Created by Paull Stanley on 9/14/22.
//

import CoreData
import CloudKit
import Domain

public class PersistentContainer: NSPersistentCloudKitContainer { }



public class StorageProvider {
    public static let shared = StorageProvider()
    private var _privatePersistentStore: NSPersistentStore?
    private var _sharedPersistentStore: NSPersistentStore?
    
    private init() { }
    
    lazy public var persistentContainer: PersistentContainer? = {
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
}

extension StorageProvider {
    public static func saveContext(_ context: NSManagedObjectContext) {
        if context.hasChanges {
            context.perform {
                do {
                    try context.save()
                } catch {
                    context.rollback()
                }
            }
        }
    }
}

extension StorageProvider {
    public var ckContainer: CKContainer {
        let storeDescription = persistentContainer!.persistentStoreDescriptions.first
        guard let identifier = storeDescription?.cloudKitContainerOptions!.containerIdentifier else {
        fatalError("Unable to get container identifier")
      }
      return CKContainer(identifier: identifier)
    }

    var context: NSManagedObjectContext {
        persistentContainer!.viewContext
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
}


//MARK: Extension for sharing
extension StorageProvider {
  public func isShared(object: ProjectDM) -> Bool {
      guard let projectId = UUID(uuidString: object.id) else { return false }
      guard let container = persistentContainer else { return false }
      let context = container.viewContext
      return context.performAndWait {
          let _object = ProjectMO.findOrInsert(using: projectId, in: context)
            isShared(objectID: object)
          return true
      }
    
  }

   public func canEdit(object: ProjectDM) -> Bool {
    guard let projectId = UUID(uuidString: object.id) else { return false }
    let _object = ProjectMO.findOrInsert(using: projectId, in: persistentContainer!.viewContext)
    return persistentContainer!.canUpdateRecord(forManagedObjectWith: _object.objectID)
  }

    public func canDelete(object: NSManagedObject) -> Bool {
    return persistentContainer!.canDeleteRecord(forManagedObjectWith: object.objectID)
  }

    public func isOwner(object: ProjectDM) -> Bool {
        guard let projectId = UUID(uuidString: object.id) else { return false }
    let _object = ProjectMO.findOrInsert(using: projectId, in: persistentContainer!.viewContext)
    guard isShared(object: object) else { return false }
    guard let share = try? persistentContainer?.fetchShares(matching: [_object.objectID])[_object.objectID] else {
      print("Get ckshare error")
      return false
    }
    if let currentUser = share.currentUserParticipant, currentUser == share.owner {
      return true
    }
    return false
  }

    public func getShare(_ project: ProjectDM) -> CKShare? {
        guard let projectId = UUID(uuidString: project.id) else { return nil }
    let _object = ProjectMO.findOrInsert(using: projectId, in: persistentContainer!.viewContext)
    guard isShared(object: project) else { return nil }
    guard let shareDictionary = try? persistentContainer?.fetchShares(matching: [_object.objectID]),
      let share = shareDictionary[_object.objectID] else {
      print("Unable to get CKShare")
      return nil
    }
    share[CKShare.SystemFieldKey.title] = project.name
    return share
  }

  private func isShared(objectID: ProjectDM) -> Bool {
      guard let projectId = UUID(uuidString: objectID.id) else { return false }
      guard let container = persistentContainer else { return false }
      let context = container.viewContext
      return context.performAndWait {
          let _object = ProjectMO.findOrInsert(using: projectId, in: context)
          var isShared = false
            if let persistentStore = _object.objectID.persistentStore {
                if persistentStore == self.sharedPersistentStore {
              isShared = true
            } else {
              let container = container
              do {
                  let shares = try container.fetchShares(matching: [_object.objectID])
                if shares.first != nil {
                  isShared = true
                }
              } catch {
                print("Failed to fetch share for \(objectID): \(error)")
              }
            }
          }
          return isShared
      }
    
  }
}

extension StorageProvider {
    
}
