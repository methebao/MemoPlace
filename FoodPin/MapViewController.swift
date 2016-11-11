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
        convertAddressToCoordinate()
        mapView.delegate = self;

    }


    // MARK: Address to Coordinate 
    func convertAddressToCoordinate() {
        let geoCoder = CLGeocoder()
        guard let location = restaurant?.location else { return }
             geoCoder.geocodeAddressString(location) { (placeMarks, error) in
                if error != nil {
                    print(error)
                    return 
                }
                if let placeMarks = placeMarks {
                    // Get first place mark
                    let placeMark = placeMarks[0]

                    // Add annotation
                    let annotation = MKPointAnnotation()
                    annotation.title = self.restaurant?.name
                    annotation.subtitle = self.restaurant?.type

                    if let location = placeMark.location {
                        annotation.coordinate = location.coordinate

                        // Display annotation 
                        self.mapView.showAnnotations([annotation], animated: true)
                        self.mapView.selectAnnotation(annotation, animated: true)
                    }

                }
             }
    }
}
// MARK: MKMapView PROTOCOLS
extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "RestaurantPin"

        if annotation.isKind(of: MKUserLocation.self){
            return nil
        }
        // Reuse the annotation if possible
        var annotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))

        if let restaurantImage = restaurant?.image {
            leftIconView.image = UIImage(data: restaurantImage as Data)
        }
        annotationView?.leftCalloutAccessoryView = leftIconView
        annotationView?.pinTintColor = UIColor.red
        return annotationView
    }
}
