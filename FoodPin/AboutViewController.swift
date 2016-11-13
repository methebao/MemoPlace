//
//  AboutViewController.swift
//  FoodPin
//
//  Created by The Bao on 11/12/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit
import SafariServices
class AboutViewController: UITableViewController {

    var sectionTitles = ["Leave Feedback", "Follow Us"]
    var sectionContent = [["Rate us on App Store", "Tell us your feedback"],
                          ["Twitter", "Facebook", "Instagram"]]
    var links = ["https://twitter.com/thebao2433",
                 "https://facebook.com/thebao2433", "https://www.instagram.com/thebaosb"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 2
        }
        return 3
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return sectionTitles[section]
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath)
        cell.textLabel?.text = sectionContent[indexPath.section][indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                if let url = URL(string: "http://thebao.me") {
                    UIApplication.shared.open(url)
                }
            } else if indexPath.row == 1 {
                performSegue(withIdentifier: "toWebView", sender: self)
            }
        case 1:
                if let url = URL(string: links[indexPath.row]) {
                    let safariController = SFSafariViewController(url: url, entersReaderIfAvailable: true)
                    present(safariController, animated: true, completion: nil)
                }
            
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: false)
    }


}
