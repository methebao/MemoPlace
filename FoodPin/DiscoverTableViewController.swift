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
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = 100.0
        loadingIndicator()
        FIRDatabase.database().reference().child("Place").observe(.childAdded, with: {
            snapshot in
                let place = RestaurantFB(snapshot: snapshot)
                self.places.append(place)
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.tableView.reloadData()
            }
        })

    }

    func loadingIndicator() {

        indicator.hidesWhenStopped = true
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
    }


    // MARK: - Table view data source

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
            let url = URL(string: imageURL)
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                DispatchQueue.main.async {
                    cell.imgView?.image = UIImage(data: data!)
                }
            }).resume()
        }
        
       // cell.imageView?.image = UIImage(named: "restaurantA")
        return cell
    }

}