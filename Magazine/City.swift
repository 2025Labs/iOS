//city

//
//  City.swift
//  mapTest
//
//  Created by MBPro on 7/18/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

import Foundation
import MapKit

class City: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let country: String
    let image: String
    let information: String
    init(title: String, coordinate: CLLocationCoordinate2D, country: String, image: String, information: String) {
        self.title = title
        self.coordinate = coordinate
        self.country = country
        self.image = image
        self.information = information
        super.init()
    }
    
    var subtitle: String? {
        return country
    }
    
}
