//
//  ViewController.swift
//  MapTest
//
//  Created by MBPro on 7/18/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

import UIKit
import MapKit
import WebImage
import Foundation
import SwiftyJSON

class ViewController: UIViewController {
    @IBOutlet weak var map: MKMapView!
    var cityArray = [City]()

    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        retrieveCityInformation()

        let initialLocation = CLLocation(latitude: 46.31, longitude: 53.62)
        centerMapOnLocation(initialLocation)
        
        for i in 0...cityArray.count-1 {
            map.addAnnotation(cityArray[i])
        }
    }
    
    func retrieveCityInformation() {

        let jsonFilePath:NSString = NSBundle.mainBundle().pathForResource("citiesJSON", ofType: "json")!
        let jsonData:NSData = NSData.dataWithContentsOfMappedFile(jsonFilePath as String) as! NSData
        let json = JSON(data: jsonData) // Note: data: parameter name
        print(json)
        for item in json.arrayValue {
            let title = item["title"].rawString()
            let latitude = item["latitude"].rawString()
            let longitude = item["longitude"].rawString()
            let country = item["country"].rawString()
            let image = item["imagefilename"].rawString()
            let information = item["information"].rawString()
            let imageFilePath = item["filepath"].rawString()
            let newCity = City(title: title!, coordinate: CLLocationCoordinate2DMake(Double(latitude!)!, Double(longitude!)!), country: country!, image: image!, information: information!, imageFilePath: imageFilePath!)
            cityArray.append(newCity)
        }
    }
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 5000000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated:true)
    }
    
    
}


