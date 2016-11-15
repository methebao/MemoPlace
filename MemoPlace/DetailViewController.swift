//
//  DetailViewController.swift
//  MemoPlace
//
//  Created by The Bao on 11/8/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var imgView: UIImageView!

    @IBOutlet var ratingButton:UIButton!

    var memoPlace: MemoPlace?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Configure UI
    func configureUI(){
        guard let memoPlace = memoPlace else { return }
        imgView.image = UIImage(data: memoPlace.image as! Data)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue:
            240.0/255.0, alpha: 0.8)
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - Configure Hide - Show Navigation Bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }


}

// MARK: TableView PROTOCOLS

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detailCell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailViewCell
        detailCell.backgroundColor = UIColor.white
        guard let memoPlace = memoPlace else { return detailCell }
        switch indexPath.row {
        case 0: detailCell.fieldLabel.text = "Name"
        detailCell.valueLabel.text = memoPlace.name
        case 1: detailCell.fieldLabel.text = "Type"
        detailCell.valueLabel.text = memoPlace.type
        case 2: detailCell.fieldLabel.text = "Location"
        detailCell.valueLabel.text = memoPlace.location
        case 3: detailCell.fieldLabel.text = "Phone"
        detailCell.valueLabel.text = memoPlace.phoneNumber
        case 4: detailCell.fieldLabel.text = "Rating"
        detailCell.valueLabel.text = memoPlace.rating
        case 5: detailCell.fieldLabel.text = "Been here"
        detailCell.valueLabel.text = (memoPlace.isVisited) ? "Yes, I've been here before": "No"
        default: detailCell.fieldLabel.text = ""
        detailCell.valueLabel.text = ""
        }
        return detailCell
    }

}
// MARK: SEGUES
extension DetailViewController {

    @IBAction func close(_ segue: UIStoryboardSegue) {
        if let reviewViewController = segue.source as? ReviewViewController {
            if let rating = reviewViewController.rating {
                memoPlace?.rating = rating
                ratingButton.setImage(UIImage(named: rating), for: UIControlState())
                tableView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let destinationController = segue.destination as! UINavigationController
            let mapViewController = destinationController.childViewControllers.first as! MapViewController
            mapViewController.memoPlace = memoPlace
        }
    }
}
