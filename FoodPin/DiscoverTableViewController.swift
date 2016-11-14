//
//  DiscoverTableViewController.swift
//  FoodPin
//
//  Created by The Bao on 11/13/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit
import FirebaseDatabase
class DiscoverTableViewController: UITableViewController {

    var places: [RestaurantFB] = []
    let refreshDataControl = UIRefreshControl()
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchRestaurantDataFromFireBase()

        }

    // MARK: Fetching Data 

    func fetchRestaurantDataFromFireBase(){
        // Remove all existing data before fetching new data
        places.removeAll()
        tableView.reloadData()

        // Fetching data from FireBase 
        
        FIRDatabase.database().reference().child("Place").observe(.childAdded, with: {
            snapshot in
            let place = RestaurantFB(snapshot: snapshot)
            self.places.append(place)
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.refreshDataControl.endRefreshing()
                self.tableView.reloadData()
            }
        })

    }
    // MARK: Configure UI
    func configureUI(){
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = 100.0
        loadingIndicator()
        refreshData()
    }

    // Loading Indicator
    func loadingIndicator() {

        indicator.hidesWhenStopped = true
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    // Refresh Control
    func refreshData() {
        refreshDataControl.backgroundColor = UIColor.white
        refreshDataControl.tintColor = UIColor.gray
        refreshDataControl.addTarget(self, action: #selector(self.fetchRestaurantDataFromFireBase), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshDataControl)
    }


}

// MARK: UITableView DataSource 
extension DiscoverTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "discoverCell", for: indexPath) as! DiscoverTableViewCell

        cell.nameLabel?.text = places[indexPath.row].name
        cell.locationLabel.text = places[indexPath.row].location
        cell.typeLabel.text = places[indexPath.row].type

        if let imageURL = places[indexPath.row].image {
            cell.imgView.loadImageUsingCacheWithURL(imageURL: imageURL)
        }
        return cell
    }
}

