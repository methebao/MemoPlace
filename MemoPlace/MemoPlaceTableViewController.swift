//
//  RestaurantTableViewController.swift
//  MemoPlace
//
//  Created by The Bao on 11/8/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit
import CoreData
import Social

class MemoPlaceTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    lazy var dataSource: MemoPlaceDataSource = {
        return MemoPlaceDataSource(tableView: self.tableView)
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
        dataSource.searchController.searchBar.placeholder = "Search memo places..."
    }

    // MARK: Search Bar
    func filterContentForSearchText(searchText: String) {
        guard let memoPlaces = dataSource.resultController.fetchedObjects else { return }

        dataSource.searchResults = memoPlaces.filter({ (memoPlace: MemoPlace) -> Bool in
            if ((memoPlace.name?.range(of: searchText, options: .caseInsensitive)) != nil) {
                return true
            }
            if ((memoPlace.location?.range(of: searchText, options: .caseInsensitive)) != nil) {
                return true
            }
            return false
        })
    }
}

// MARK: SEGUES

extension MemoPlaceTableViewController {

    @IBAction func unwindToHomeScreen(_segue: UIStoryboardSegue){
    }
}

// MARK: TableView DELEGATE

extension MemoPlaceTableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  TO Detail View Controller
        let detailController = storyboard?.instantiateViewController(withIdentifier: "detailView") as! DetailViewController
        detailController.memoPlace = (dataSource.searchController.isActive) ? dataSource.searchResults[indexPath.row] : dataSource.resultController.object(at: indexPath)
        detailController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailController, animated: true)
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let restaurant = dataSource.resultController.object(at: indexPath)

        // Social Sharing Button
        let twitterAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Twitter", handler: { (action, indexPath) -> Void in

            guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) else {
                let alertMessage = UIAlertController(title: "Twitter Unavailable",message: "You haven't registered your Twitter account. Please go to Settings > Twitter to create one.", preferredStyle: .alert)
                    alertMessage.addAction(UIAlertAction(title: "OK", style: .default,
                                                         handler: nil))
                self.present(alertMessage, animated: true, completion: nil)
                return
            }
            let tweetComposer = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetComposer?.setInitialText(restaurant.name)
            tweetComposer?.add(UIImage(data:restaurant.image as! Data))
            if let tweetComposer = tweetComposer {
                self.present(tweetComposer, animated: true, completion: nil)
            }
        })

        let facebookAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Facebook", handler: { (action, indexPath) -> Void in

            guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) else {
                let alertMessage = UIAlertController(title: "Facebook Unavailable",message: "You haven't registered your Facebook account. Please go to Settings > Facebook to create one.", preferredStyle: .alert)
                alertMessage.addAction(UIAlertAction(title: "OK", style: .default,
                                                     handler: nil))
                self.present(alertMessage, animated: true, completion: nil)
                return
            }
            let facebookComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookComposer?.setInitialText(restaurant.name)
            facebookComposer?.add(UIImage(data:restaurant.image as! Data))
            facebookComposer?.add(URL(string: "http://thebao.me"))
            if let tweetComposer = facebookComposer {
                self.present(tweetComposer, animated: true, completion: nil)
            }
        })

        // Delete button
        let deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Delete",handler: { (action, indexPath) -> Void in
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(restaurant)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        })

        // Set the button color
        facebookAction.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        twitterAction.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)

        return [deleteAction, twitterAction, facebookAction]
    }

}
//MARK: Search Controller DELEGATES
extension MemoPlaceTableViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContentForSearchText(searchText: searchText)
            tableView.reloadData()
        }
    }
}
