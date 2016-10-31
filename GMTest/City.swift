//
//  City.swift
//  GMTest
//
//  Created by Alex Dontsov on 31.10.16.
//  Copyright © 2016 Kinect.Pro. All rights reserved.
//

import UIKit
import GoogleMaps

class City{
    
    let title: String
    let coordinates: CLLocationCoordinate2D
    
    init(title: String, coordinates: CLLocationCoordinate2D) {
        self.title = title
        self.coordinates = coordinates
    }
    
    class func availableCities() -> Array<City> {
        return [ City(title: "San Francisco", coordinates: CLLocationCoordinate2D(latitude: 37.7689082, longitude: -122.4322784)),
                 City(title: "New York", coordinates: CLLocationCoordinate2D(latitude: 40.728333, longitude: -73.994167)),
        ]
    }
    
}
