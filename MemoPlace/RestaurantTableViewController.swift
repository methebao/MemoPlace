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
        tableView.dataSource = dataSource
        dataSource.searchController = UISearchController(searchResultsController: nil)
        configureUI()

    }


    // MARK: Walkthrough Page Controller
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Check viewd Walkthrough
        let defaults = UserDefaults.standard
        let hasViewedWalkthrough = defaults.bool(forKey: "hasViewedWalkthrough")
        if hasViewedWalkthrough {
            return
        }

        // Present Walkthrough
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "WalkthroughController"){
            present(pageViewController, animated: true, completion: nil)
        }

    }

    // MARK: - Configure Hide - Show Navigation Bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
    }


    // MARK: - Configure UI
    func configureUI(){
      
        // Table View
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        // Search Bar
        tableView.tableHeaderView = dataSource.searchController.searchBar
        dataSource.searchController.searchResultsUpdater = self
        dataSource.searchController.hidesNavigationBarDuringPresentation = false
        dataSource.searchController.dimsBackgroundDuringPresentation = false
        dataSource.searchController.searchBar.barTintColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            dataSource.searchController.searchBar.tintColor = UIColor.white
        dataSource.searchController.searchBar.placeholder = "Search restaurants..."
    }

    // MARK: Search Bar
    func filterContentForSearchText(searchText: String) {
        guard let restaurants = dataSource.resultController.fetchedObjects else { return }
        dataSource.searchResults = restaurants.filter({ (restaurant: Restaurant) -> Bool in
            if ((restaurant.name?.range(of: searchText, options: .caseInsensitive)) != nil) {
                return true
            }
            if ((restaurant.location?.range(of: searchText, options: .caseInsensitive)) != nil) {
                return true
            }
            return false
        })
    }
}

// MARK: SEGUES

extension RestaurantTableViewController {

    @IBAction func unwindToHomeScreen(_segue: UIStoryboardSegue){
    }
}

// MARK: TableView DELEGATE

extension RestaurantTableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  TO Detail View Controller
        let detailController = storyboard?.instantiateViewController(withIdentifier: "detailView") as! DetailViewController
        detailController.restaurant = (dataSource.searchController.isActive) ? dataSource.searchResults[indexPath.row] : dataSource.resultController.object(at: indexPath)
        detailController.hidesBottomBarWhenPushed = true 
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

}
//MARK: Search Controller DELEGATES
extension RestaurantTableViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContentForSearchText(searchText: searchText)
            tableView.reloadData()
        }
    }
}
