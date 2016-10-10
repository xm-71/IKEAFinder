//
//  IKEA.swift
//  IKEAFinder
//
//  Created by Elliott, Rob on 9/26/16.
//  Copyright © 2016 Elliott, Rob. All rights reserved.
//

import UIKit
import MapKit

class IKEA: NSObject, MKAnnotation {
    var name: String
    var city: String
    var state: String
    var smalland: Bool
    var storeImage: String
    var latitude: Double
    var longitude: Double
    var distanceFromCurrentLocation: Double?
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
    
    var title: String? {
        return name
    }
    
    
    init (name: String, city: String, state: String, smalland: Bool, storeImage: String, latitude: Double, longitude: Double) {
        self.name = name
        self.city = city
        self.state = state
        self.smalland = smalland
        self.storeImage = storeImage
        self.latitude = latitude
        self.longitude = longitude
        
        super.init()
    }
    
    
    func calculateDistance(userLocation: CLLocation)-> Double{
    
        let storeLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
    
        self.distanceFromCurrentLocation = storeLocation.distanceFromLocation(userLocation) * 0.000621371
        
        return self.distanceFromCurrentLocation!
        
    }
    
    
}//end ikea class


