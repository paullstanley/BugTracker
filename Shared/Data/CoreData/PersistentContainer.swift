//
//  PersistentContainer.swift
//  IssueTrackingSystem (iOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import CoreData

func startPersistentContainer() throws-> NSPersistentContainer {
    let persistentContainer = NSPersistentContainer(name: "IssueTrackingSystem")
    //persistentContainer.persistentStoreDescriptions.first!.url =
    //URL(fileURLWithPath: "/dev/null")
    
    persistentContainer.loadPersistentStores { description, error in
        if let error = error {
            fatalError("Unable to load persistent container \(error.localizedDescription)")
        }
    }
    return persistentContainer
}
