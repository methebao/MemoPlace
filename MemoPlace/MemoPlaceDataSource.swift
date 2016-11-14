//
//  RestaurantDataSource.swift
//  MemoPlace
//
//  Created by The Bao on 11/11/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class MemoPlaceDataSource: NSObject, UITableViewDataSource {
    private let tableView: UITableView

    var searchController: UISearchController!

    var searchResults: [MemoPlace] = []

    let managedObjectcontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    lazy var resultController: MemoPlaceFetchResultController = {
        let controller = MemoPlaceFetchResultController(managedObjectContext: self.managedObjectcontext, withTableView: self.tableView)
        return controller
    }()

    init(tableView: UITableView) {
        self.tableView = tableView
    }
    func object(at indexPath: IndexPath) -> MemoPlace {
        return resultController.object(at: indexPath)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return resultController.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if searchController.isActive {
            return searchResults.count
        }

        return resultController.sections?[section].numberOfObjects ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurant = (searchController.isActive) ? searchResults[indexPath.row] : resultController.object(at: indexPath)
        let restaurantCell = tableView.dequeueReusableCell(withIdentifier: "MemoPlaceCell", for: indexPath) as! MemoPlaceViewCell

        restaurantCell.imgView.image = UIImage(data: restaurant.image as! Data)
        restaurantCell.nameLabel.text = restaurant.name
        restaurantCell.locationLabel.text = restaurant.location
        restaurantCell.typeLabel.text = restaurant.type
        restaurantCell.imgView?.layer.cornerRadius = 30.0
        restaurantCell.imgView?.clipsToBounds = true

        return restaurantCell
    }


    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchController.isActive {
            return false
        }
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    
}
