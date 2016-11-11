//
//  AddRestaurantController.swift
//  FoodPin
//
//  Created by The Bao on 11/9/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit
import CoreData
class AddRestaurantController: UITableViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    var isVisited = true
    var restaurant: Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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

    // CHECK Fields completed 
    @IBAction func selectBeenHereField(sender: UIButton) {

        switch sender.tag {
        case 1:
            yesButton.backgroundColor = UIColor.red
            noButton.backgroundColor = UIColor.gray

        case 2:
            isVisited = false
            noButton.backgroundColor = UIColor.red
            yesButton.backgroundColor = UIColor.gray

        default: break
        }
    }
    @IBAction func saveFilledInformations() {
        guard nameField.text?.isEmpty == false , typeField.text?.isEmpty == false, locationField.text?.isEmpty == false else {
            showAlert(title: "Can't Save", message: "Because name fields is blank. Please note that all fields are required.", style: .alert)
            return
        }
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context = appDel.persistentContainer.viewContext
        restaurant = NSEntityDescription.insertNewObject(forEntityName: "Restaurant", into: context) as! Restaurant
        // Bonus feature : Handle user fill " " and not have any characters. 
        restaurant.name = nameField.text
        restaurant.type = typeField.text
        restaurant.location = locationField.text
        if let image = UIImagePNGRepresentation((imgView.image)!) {
            restaurant.image = image as NSData?
        }
        restaurant.isVisited = isVisited

        appDel.saveContext()



        // Handled Filling Informations

        performSegue(withIdentifier: "unwindToHomeScreen", sender: self)
        dismiss(animated: true, completion: nil)

    }
    // Alert Controller
    func showAlert(title: String?, message: String?, style: UIAlertControllerStyle) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

}

// MARK:  UIImagePicker PROTOCOLS
extension AddRestaurantController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        imgView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imgView.contentMode = UIViewContentMode.scaleAspectFill
        imgView.clipsToBounds = true

        // Auto Layout Constraints 

        let leadingConstraint = NSLayoutConstraint(item: imgView, attribute: .leading, relatedBy: .equal, toItem: imgView.superview, attribute: .leading, multiplier: 1.0, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: imgView, attribute: .trailing, relatedBy: .equal, toItem: imgView.superview, attribute: .trailing, multiplier: 1.0, constant: 0)
        let topConstraint = NSLayoutConstraint(item: imgView, attribute: .top, relatedBy: .equal, toItem: imgView.superview, attribute: .top, multiplier: 1.0, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: imgView, attribute: .bottom, relatedBy: .equal, toItem: imgView.superview, attribute: .bottom, multiplier: 1.0, constant: 0)
        let constraints: [NSLayoutConstraint] = [leadingConstraint,trailingConstraint,topConstraint,bottomConstraint]
        _ = constraints.map { $0.isActive = true }


        dismiss(animated: true, completion: nil)

    }
}

