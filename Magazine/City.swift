//city

//
//  City.swift
//  mapTest
//
//  Created by 2025 Labs on 7/18/16.
//  Copyright @ 2017 2025 Labs LLC. All rights reserved.
//

import Foundation
import MapKit

class City: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let country: String
    let image: String
    let information: String
    let imageFilePath: String
    init(title: String, coordinate: CLLocationCoordinate2D, country: String, image: String, information: String, imageFilePath: String) {
        self.title = title
        self.coordinate = coordinate
        self.country = country
        self.image = image
        self.information = information
        self.imageFilePath = imageFilePath
        super.init()
    }
    
    var subtitle: String? {
        return country
    }
    
}
