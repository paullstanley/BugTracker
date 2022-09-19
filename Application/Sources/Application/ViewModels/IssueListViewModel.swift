//
//  IssueListViewModel.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import CoreData
import CoreDataPlugin

class IssueListViewModel: NSObject, ObservableObject {
    @Published private(set) var issues: [IssueMO] = [IssueMO]()
    
    private let storageProvider: StorageProvider = StorageProvider()
    private let fetchedResultsController: NSFetchedResultsController<IssueMO>
    
    override init() {
        let request: NSFetchRequest<IssueMO> = IssueMO.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \IssueMO.id,
                                                   ascending: false)]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                   managedObjectContext: storageProvider.persistentContainer!.viewContext,
                                                                   sectionNameKeyPath: nil,
                                                                   cacheName: nil)
        super.init()
        
        fetchedResultsController.delegate = self
        try! fetchedResultsController.performFetch()
        issues = fetchedResultsController.fetchedObjects ?? []
    }
}

extension IssueListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        issues = controller.fetchedObjects as? [IssueMO] ?? []
    }
}
