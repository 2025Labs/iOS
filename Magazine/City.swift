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
    let locationName: String
    let image: String
    let information: String
    init(title: String, coordinate: CLLocationCoordinate2D, locationName: String, image: String, information: String) {
        self.title = title
        self.coordinate = coordinate
        self.locationName = locationName
        self.image = image
        self.information = information
        super.init()
    }
    
    var subtitle: String? {
        return title
    }
    
}
