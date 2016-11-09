//
//  AddRestaurantController.swift
//  FoodPin
//
//  Created by The Bao on 11/9/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit

class AddRestaurantController: UITableViewController {

    @IBOutlet weak var imgView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

    }

    // Configure UI 

    func configureUI(){

        // Navigation
        if let barFont = UIFont(name: "Avenir-Light", size: 24.0) {
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white,NSFontAttributeName: barFont]
        }
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 242.0/255.0, green:
            116.0/255.0, blue: 119.0/255.0, alpha: 1.0)

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self 
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }


}

// MARK:  UIImagePickerControllerDelegate PROTOCOLS
extension AddRestaurantController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        imgView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imgView.contentMode = UIViewContentMode.scaleAspectFill
        imgView.clipsToBounds = true

        let leadingConstraint = NSLayoutConstraint(item: imgView, attribute: .leading, relatedBy: .equal, toItem: imgView.superview, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: imgView, attribute: .trailing, relatedBy: .equal, toItem: imgView.superview, attribute: .trailing, multiplier: 1.0, constant: 0)
        let topConstraint = NSLayoutConstraint(item: imgView, attribute: .top, relatedBy: .equal, toItem: imgView.superview, attribute: .top, multiplier: 1.0, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: imgView, attribute: .bottom, relatedBy: .equal, toItem: imgView.superview, attribute: .bottom, multiplier: 1.0, constant: 0)
        let constraints: [NSLayoutConstraint] = [leadingConstraint,trailingConstraint,topConstraint,bottomConstraint]
        _ = constraints.map { $0.isActive = true }



        dismiss(animated: true, completion: nil)

    }
}

