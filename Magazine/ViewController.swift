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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        let initialLocation = CLLocation(latitude: 12.9, longitude: 77.6)
        
        centerMapOnLocation(initialLocation)
        
        let bangalore = City(title: "Bangalore", coordinate: CLLocationCoordinate2DMake(12.9716, 77.5946), locationName: "Bangalore, India", image: "bangalore.jpg", information: "Bangalore, India is well known for information technology companies to which other companies hire out their work. Among these IT outsourcers: Infosys, Tata, and Wipro. Tech companies all over the world make use of IT talent from Indian companies. India hopes to move beyond outsourcing to more home grown companies.")
        
        let hongkong = City(title: "Hong Kong", coordinate: CLLocationCoordinate2DMake(22.3964, 114.1095), locationName: "Hong Kong", image: "hongkong.jpg", information:"Hong Kong, China is compared to hot startup locations like London and New York. It is considered an emerging tech hub by sources such as Forbes, Inc. In face, Hong Kong has one of the fastest growing startup communities in the world. With only 7 million residents, a whopping 150,000 new businesses were started in 2011 alone. With its rich startup environment, it is nicknamed \"Silicon Harbour\" in comparison to Silicon Valley.")
        
        let telaviv = City(title:"Tel Aviv", coordinate: CLLocationCoordinate2DMake(32.0853, 34.7818), locationName: "Tel Aviv", image:"telaviv.jpg", information:"Tel Aviv, Israel is not big, but it is an emerging technology center with a thriving startup scene. According to the bbc, high tech exports amounted to about $18 billion per year, and about 45% of Israel's exports. There is so much startup activity that there is one startup for every 431 residents.")
        
        map.addAnnotation(bangalore);
        map.addAnnotation(hongkong);
        map.addAnnotation(telaviv);
        
    }
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated:true)
    }
    
    
}


