//
//  ViewController.swift
//  MapTest
//
//  Created by 2025 Labs on 7/18/16.
//  Copyright @ 2017 2025 Labs LLC. All rights reserved.
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
        //map.isZoomEnabled = false

        retrieveCityInformation()
        
        //let initialLocation = CLLocation(latitude: 36.87, longitude: -1.15)
        //centerMapOnLocation(initialLocation)

        let span = MKCoordinateSpanMake(180, 360)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 35.56, longitude: -42.16), span: span)
        map.setRegion(region, animated: true)
        
        for city in cityArray {
            map.addAnnotation(city)
        }
        
        
        
        
    }
    
    //The library used to pull JSON information in this file is called SwiftyJSON
    func retrieveCityInformation() {

        let jsonFilePath:NSString = Bundle.main.path(forResource: "energy2017JSON-stage", ofType: "json")! as NSString
        let jsonData:NSData = NSData.dataWithContentsOfMappedFile(jsonFilePath as String) as! NSData
        //let jsonData:NSData = NSData.withContentsOfFile(jsonFilePath as String) as NSData!
        let json = JSON(data: jsonData as Data) // Note: data: parameter name
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
    
    func centerMapOnLocation(_ location: CLLocation) {
        let regionRadius: CLLocationDistance = 5000000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated:true)
    }
    
    
}


