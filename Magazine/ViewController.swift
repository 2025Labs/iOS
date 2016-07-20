//
//  ViewController.swift
//  MapTest
//
//  Created by MBPro on 7/18/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var leftBottomButton: UIButton!
    var cityArray = [City]()

    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        let initialLocation = CLLocation(latitude: 12.9, longitude: 77.6)
        connectToDatabase()
        centerMapOnLocation(initialLocation)
        
        for i in 0...cityArray.count-1 {
            map.addAnnotation(cityArray[i])
        }

    }
    
    func connectToDatabase() {
        let connectionString = "user=rwpham password=richard1 dbname=postgres  port=5432 host=52.9.114.219"
        let connection = PQconnectdb(connectionString)
        if(PQstatus(connection) != CONNECTION_OK) {
            print("Error: Couldn't connect to the database")
        }
        
        var result = PQexec(connection, "begin")
        if(PQresultStatus(result) != PGRES_COMMAND_OK) {
            print("Begin command failed")
        }
        PQclear(result)
        
        result = PQexec(connection, "SELECT * FROM cities")
        
        if(PQresultStatus(result) != PGRES_TUPLES_OK) {
            print("Couldn't fetch anything")
        }
        for i in 0...PQntuples(result)-1 {
            
            let title = String.fromCString(PQgetvalue(result, i, 0))
            let latitude = String.fromCString(PQgetvalue(result, i, 1))
            let longitude = String.fromCString(PQgetvalue(result, i, 2))
            let country = String.fromCString(PQgetvalue(result, i, 3))
            let image = String.fromCString(PQgetvalue(result, i, 4))
            let information = String.fromCString(PQgetvalue(result, i, 5))
        
            let newCity = City(title: title!, coordinate: CLLocationCoordinate2DMake(Double(latitude!)!, Double(longitude!)!), country: country!, image: image!, information: information!)
            
            cityArray.append(newCity)
        }
    }
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated:true)
    }
    
    
}


