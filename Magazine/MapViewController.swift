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


@objc class MapViewController: UIViewController {
    @IBOutlet weak var map: MKMapView!
    var cityArray = [City]()
    @objc var mapTopic : String? // variable used in obj-c and swift

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
        // how we use our objective c object in our swift file
        //let controller: ViewController = ViewController()
        //let file  = controller.currentTopic
        let jsonFilePath:NSString = Bundle.main.path(forResource: "citiesJSON", ofType: "json")! as NSString
        let jsonData:NSData = NSData.dataWithContentsOfMappedFile(jsonFilePath as String) as! NSData
        //let jsonData:NSData = NSData.withContentsOfFile(jsonFilePath as String) as NSData!
        let json = JSON(data: jsonData as Data) // Note: data: parameter name
        //print(json)
        for item in json.arrayValue {
            // allows to read data by topic
            if item["topic"].rawString() == mapTopic {
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
         /* else if tunnel == "energy" {
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
        }*/
    }

    func centerMapOnLocation(_ location: CLLocation) {
        let regionRadius: CLLocationDistance = 5000000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated:true)
    }
    
/*
 prepareForSegue is where we pass the topic and filename for which we wish to display
 when we transition into a new scene. The new scene will load up by looking at its
 current topic and/or the filename and display content accordingly.
*/
    func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "showNews") {
            let controller = segue.destination as? News
            let currentTopic = "computing"
            controller?.note = "article"
            controller?.currentTopic = currentTopic
            controller?.pageNumber = 0
        } else if (segue.identifier == "showPuzzle") {
            let controller = segue.destination as? PuzzleNavigation
            controller?.currentTopic = "computing"
            controller?.fileName = "wordsearch.png"
        }
    }
    
    /*
    func getFilePathFromJSON () {
        //  Converted to Swift 4 by Swiftify v1.0.6561 - https://objectivec2swift.com/
        var filePath: String? = Bundle.main.path(forResource: "imagesJSON", ofType: "json")
        var myJSON = try? String(contentsOfFile: filePath ?? "", encoding: .utf8)
        var error: Error? = nil
        var jsonDataArray = (try? JSONSerialization.jsonObject(with: myJSON?.data(using: .utf8) ?? Data(), options: [])) as? [Any]
        //To pull item based on topic, add a conditional that says
        //[item objectForKey:@"topic"] isEqual: @"energy"] in addition to the @"notes" key
        for item: [AnyHashable: Any] in jsonDataArray {
            if item["filename"] == filename {
                filepath = item["filepath"]
            }
        }

    }*/
}
    



