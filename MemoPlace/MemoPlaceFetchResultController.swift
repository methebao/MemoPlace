//
//  RestaurantFetchResultController.swift
//  MemoPlace
//
//  Created by The Bao on 11/11/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class MemoPlaceFetchResultController: NSFetchedResultsController<MemoPlace>,NSFetchedResultsControllerDelegate {
    private let tableView: UITableView

    init(managedObjectContext: NSManagedObjectContext, withTableView tableView: UITableView) {
        self.tableView = tableView
        super.init(fetchRequest: MemoPlace.fetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        self.delegate = self
        tryFetch()
    }

    func tryFetch() {
        do {
            try performFetch()
        }catch let error {
            print("Unresolved Error: \(error), \(error.localizedDescription)")
        }
    }
    // NSFetchResultController DELEGATE

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .insert:
            guard let indexPath = newIndexPath else { return }
            tableView.insertRows(at: [indexPath], with: .automatic)
        case .move, .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
