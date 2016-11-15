//
//  MapViewDelegate.swift
//  MemoPlace
//
//  Created by The Bao on 11/15/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import Foundation
import UIKit
import MapKit
// MARK: MKMapView PROTOCOLS
extension MapViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MemoPlacePin"

        if annotation.isKind(of: MKUserLocation.self){
            return nil
        }
        // Reuse the annotation if possible
        var annotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        // Check current placemark == annotation -> custom view annotation
        if let currentPlaceMarkCoordinate = currentPlacemark?.location?.coordinate {
            if currentPlaceMarkCoordinate.latitude == annotation.coordinate.latitude && currentPlaceMarkCoordinate.longitude == annotation.coordinate.longitude{

                let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 53, height: 53))

                if let restaurantImage = self.memoPlace?.image {
                    leftIconView.image = UIImage(data: restaurantImage as Data)
                }
                annotationView?.leftCalloutAccessoryView = leftIconView
                annotationView?.pinTintColor = UIColor.red

            } else {
                annotationView?.pinTintColor = UIColor.orange
            }

        }

        // Add action to move on route table view 
        annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

        return annotationView
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = (currentTranspotType == .automobile) ? UIColor.blue : UIColor.orange
        render.lineWidth = 3.0
        return render
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: "showSteps", sender: view)
    }

}
