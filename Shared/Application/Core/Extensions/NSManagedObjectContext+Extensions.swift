//
//  NSManagedObjectContext+Extensions.swift
//  IssueTrackingSystem (macOS)
//
//  Created by Paull Stanley on 9/7/22.
//

import CoreData

extension NSManagedObjectContext {
    func configureAsWriterContext() {
        automaticallyMergesChangesFromParent = true
        mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
}

extension NSManagedObjectContext {
    func configureAsReaderContext(to _parent: NSManagedObjectContext) {
        automaticallyMergesChangesFromParent = true
        mergePolicy = NSRollbackMergePolicy
        undoManager = nil
        shouldDeleteInaccessibleFaults = true
        parent = _parent
    }
}

extension NSManagedObjectContext {
    func performAndWait<T>(_ block: () throws -> T) rethrows -> T {
        return try _performAndWaitHelper(
            fn: performAndWait, execute: block, rescue: { throw $0 }
        )
    }
    private func _performAndWaitHelper<T>(
            fn: (() -> Void) -> Void,
            execute work: () throws -> T,
            rescue: ((Error) throws -> (T))) rethrows -> T
        {
            var result: T?
            var error: Error?
            withoutActuallyEscaping(work) { _work in
                fn {
                    do {
                        result = try _work()
                    } catch let e {
                        error = e
                    }
                }
            }
            if let e = error {
                return try rescue(e)
            } else {
                return result!
            }
        }
    }
