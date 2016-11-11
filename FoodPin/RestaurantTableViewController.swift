//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by The Bao on 11/8/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit
import CoreData
class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    lazy var dataSource: RestaurantDataSource = {
        return RestaurantDataSource(tableView: self.tableView)
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        tableView.dataSource = dataSource
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        UIApplication.shared.statusBarStyle = .lightContent

    }

    // MARK: - Configure Navigation Bar 
    func configureUI(){

        // Navigation
        if let barFont = UIFont(name: "Avenir-Light", size: 24.0) {
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white,NSFontAttributeName: barFont]
        }
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 242.0/255.0, green:
            116.0/255.0, blue: 119.0/255.0, alpha: 1.0)
        title = "FoodPin"

        // Table View
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension


    }
    
    // MARK: TableView DELEGATE
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  TO Detail View Controller
        let detailController = storyboard?.instantiateViewController(withIdentifier: "detailView") as! DetailViewController
        detailController.restaurant = dataSource.resultController.object(at: indexPath)
        navigationController?.pushViewController(detailController, animated: true)
    }
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let restaurant = dataSource.resultController.object(at: indexPath)
        // Social Sharing Button
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Share", handler: { (action, indexPath) -> Void in

            let defaultText = "Just checking in at " + restaurant.name!

            if let imageToShare = UIImage(data: restaurant.image as! Data) {
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)

                self.present(activityController, animated: true, completion: nil)
            }
        })

        // Delete button
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete",handler: { (action, indexPath) -> Void in
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(restaurant)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        })

        // Set the button color
        shareAction.backgroundColor = UIColor.blue
        deleteAction.backgroundColor = UIColor.red

        return [deleteAction, shareAction]
    }


//
}

// MARK: SEGUES 

extension RestaurantTableViewController {

    @IBAction func unwindToHomeScreen(_segue: UIStoryboardSegue){
    }
}

