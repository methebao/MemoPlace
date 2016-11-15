//
//  RouteTableViewController.swift
//  MemoPlace
//
//  Created by The Bao on 11/15/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit
import MapKit
class RouteTableViewController: UITableViewController {

    var routeSteps = [MKRouteStep]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return routeSteps.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeCell", for: indexPath)
        cell.textLabel?.text = routeSteps[indexPath.row].instructions
        return cell
    }

}
