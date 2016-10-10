//
//  MapViewController.swift
//  IKEAFinder
//
//  Created by RobElliott on 10/3/16.
//  Copyright © 2016 Elliott, Rob. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // ATTRIBUTES
    
    var mappedIKEA: IKEA!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager: CLLocationManager!
    
    
    
    // EVENT LIFECYCLE METHODS
    
    
    override func viewWillAppear(animated: Bool) {
        
        
        // CENTER AND ZOOM THE MAP
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(mappedIKEA.coordinate, 20000, 20000)
        
        mapView.setRegion(coordinateRegion, animated: true)
        
        
        // ADD THE PIN
        mapView.addAnnotation(mappedIKEA)
        
        
        // AUTO-SHOW THE PIN TITLE
        mapView.selectAnnotation(mapView.annotations.last!, animated: true)
        
        
        // SHOW THE USER LOCATION ON THE MAP
        mapView.showsUserLocation = true
        
    }
    
    override func viewDidLoad() {
        mapView.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    
    // LOCATION MANAGER DELEGATE METHODS
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print("Location changed!")
        
        var mapCenter: CLLocation = CLLocation()
        var mapRegionSize: Double = 0
        
        // CENTER THE MAP
        
        if let userPosition = locations.last!.coordinate as CLLocationCoordinate2D? {
            mapCenter = calculateCenterPoint(userPosition, location2: mappedIKEA.coordinate)
            mapRegionSize = calculateRegionSize(userPosition, location2: mappedIKEA.coordinate)
        }
        
        centerMapOnLocation(mapCenter, distance: mapRegionSize)
        
        
        // DETERMINE THE REGION SIZE
        
        
    }
    
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? IKEA {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            }
            return view
        }
        return nil
    }
    
    
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("Tapped")
    }
    
    
    
    func calculateCenterPoint(location1: CLLocationCoordinate2D, location2: CLLocationCoordinate2D) -> CLLocation {
        
        let lon1: Double = location1.longitude * M_PI / 180;
        let lon2: Double = location2.longitude * M_PI / 180;
        
        let lat1: Double = location1.latitude * M_PI / 180;
        let lat2: Double = location2.latitude * M_PI / 180;
        
        let dLon: Double = lon2 - lon1;
        
        let x: Double = cos(lat2) * cos(dLon);
        let y: Double = cos(lat2) * sin(dLon);
        
        var lat3: Double = atan2( sin(lat1) + sin(lat2), sqrt((cos(lat1) + x) * (cos(lat1) + x) + y * y) );
        var lon3: Double = lon1 + atan2(y, cos(lat1) + x);
        
        lat3  = lat3 * 180 / M_PI;
        lon3 = lon3 * 180 / M_PI;
        
        let center: CLLocation = CLLocation(latitude: lat3, longitude: lon3)
        
        return center;
    }

    
    func centerMapOnLocation(location: CLLocation, distance: Double) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, distance, distance)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func calculateRegionSize(location1: CLLocationCoordinate2D, location2: CLLocationCoordinate2D) -> Double {
        
        // CREATE CLLOCATION OBJECTS
        let regionLocation1: CLLocation = CLLocation(latitude: location1.latitude, longitude: location1.longitude)
        
        let regionLocation2: CLLocation = CLLocation(latitude: location2.latitude, longitude: location2.longitude)
        
        // USE THE BUILT-IN METHOD TO GET THE DISTANCE BETWEEN THEM
        
        let distanceInMeters: CLLocationDistance = regionLocation1.distanceFromLocation(regionLocation2)
        
        return distanceInMeters
    }
    
    
    
} // end of MapViewController class declaration
