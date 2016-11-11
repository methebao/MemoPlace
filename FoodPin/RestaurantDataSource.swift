//
//  RestaurantDataSource.swift
//  FoodPin
//
//  Created by The Bao on 11/11/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class RestaurantDataSource: NSObject, UITableViewDataSource {
    private let tableView: UITableView

    let managedObjectcontext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    lazy var resultController: RestaurantFetchResultController = {
        let controller = RestaurantFetchResultController(managedObjectContext: self.managedObjectcontext, withTableView: self.tableView)
        return controller
    }()
    
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    func object(at indexPath: IndexPath) -> Restaurant {
        return resultController.object(at: indexPath)
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return resultController.sections?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultController.sections?[section].numberOfObjects ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurant = resultController.object(at: indexPath)
        let restaurantCell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantViewCell

        restaurantCell.imgView.image = UIImage(data: restaurant.image as! Data)
        restaurantCell.nameLabel.text = restaurant.name
        restaurantCell.locationLabel.text = restaurant.location
        restaurantCell.typeLabel.text = restaurant.type
        restaurantCell.imgView?.layer.cornerRadius = 30.0
        restaurantCell.imgView?.clipsToBounds = true

        return restaurantCell
    }
   

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

    }

  
}
