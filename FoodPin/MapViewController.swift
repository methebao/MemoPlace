//
//  MapViewController.swift
//  FoodPin
//
//  Created by The Bao on 11/9/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    var restaurant: Restaurant?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Address to Coordinate 
    func convertAddressToCoordinate() {
        let geoCoder = CLGeocoder()
        guard let location = restaurant?.location else { return }
             geoCoder.geocodeAddressString(location) { (placeMarks, error) in
                guard error != nil else {
                    print(error)
                    return }
             }


    }
}
