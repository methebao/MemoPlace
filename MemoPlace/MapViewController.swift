//
//  MapViewController.swift
//  MemoPlace
//
//  Created by The Bao on 11/9/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var memoPlace: MemoPlace?
    let locationManager = CLLocationManager()
    var currentPlacemark: CLPlacemark?
    var currentTranspotType = MKDirectionsTransportType.automobile
    var currentRoute: MKRoute?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configSegmentedControl()
        convertAddressToCoordinate()
        mapView.delegate = self

        // Check location permission
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse {
            mapView.showsUserLocation = true
        }

    }
    //MARK: Segmented Control 
    func configSegmentedControl(){
        segmentedControl.isHidden = true
        segmentedControl.addTarget(self, action: #selector(MapViewController.showDirection), for: .valueChanged)
    }

   

    // MARK: Address to Coordinate
    func convertAddressToCoordinate() {
        let geoCoder = CLGeocoder()
        guard let location = memoPlace?.location else { return }
        geoCoder.geocodeAddressString(location) { (placeMarks, error) in
            if error != nil {
                print("Unresolved Error: \(error), \(error?.localizedDescription)")
                return
            }
            if let placeMarks = placeMarks {
                // Get first place mark
                let placeMark = placeMarks[0]
                self.currentPlacemark = placeMark
                // Add annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.memoPlace?.name
                annotation.subtitle = self.memoPlace?.type

                if let location = placeMark.location {
                    annotation.coordinate = location.coordinate

                    // Display annotation
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }

            }
        }
    }
    // MARK: showDirection
    @IBAction func showDirection() {

        segmentedControl.isHidden = false

        switch segmentedControl.selectedSegmentIndex {
        case 0: currentTranspotType = .automobile
        case 1: currentTranspotType = .walking
        default: break
        }

        guard let currentPlacemark = currentPlacemark else {
            return
        }

        let directionRequest = MKDirectionsRequest()
        // Set the source and destination of the route
        directionRequest.source = MKMapItem.forCurrentLocation()
        let destinationPlacemark = MKPlacemark(placemark: currentPlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = currentTranspotType

        // Calculate the Direction
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (routeResponse, error) in

            guard let routeResponse = routeResponse else {
                if let error = error  {
                    print("Unsolved Error: \(error),\(error.localizedDescription)")
                }
                return
            }

            let route = routeResponse.routes[0]
            // Update current route
            self.currentRoute = route

            self.mapView.removeOverlays(self.mapView.overlays)
            self.mapView.add(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)

        }

    }
    // MARK: Nearby 
    @IBAction func showNearby() {
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = memoPlace?.type
        searchRequest.region = mapView.region

        let localSearch = MKLocalSearch(request: searchRequest)
        localSearch.start { (searchResponse, error) in
            guard let searchResponse = searchResponse else {
                if let error = error {
                    print("Unsolved Error: \(error), \(error.localizedDescription)")
                }
                return
            }
            let mapItems = searchResponse.mapItems
            var nearByAnnotation = [MKAnnotation]()
            if mapItems.count > 0 {
                for item in mapItems {
                    // Add annotation
                    let annotation = MKPointAnnotation()
                    annotation.title = item.name
                    annotation.subtitle = item.phoneNumber
                    if let location = item.placemark.location {
                        annotation.coordinate = location.coordinate
                    }
                    nearByAnnotation.append(annotation)
                }
            }
            self.mapView.showAnnotations(nearByAnnotation, animated: true)
        }
    }

    // MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSteps" {
            let routeController = segue.destination as! RouteTableViewController
            if let steps = currentRoute?.steps {
                print(steps)
                routeController.routeSteps = steps
            }
        }
    }

}

