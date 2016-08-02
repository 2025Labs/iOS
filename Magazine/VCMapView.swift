//
//  VCMapView.swift
//  mapTest
//
//  Created by MBPro on 7/18/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

import Foundation
import MapKit
import Popover
import WebImage

extension ViewController: MKMapViewDelegate {
    
    // 1
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? City {
            let identifier = annotation.country
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
               
            }
            return view
        }
        return nil
    }

    func mapView(mapView: MKMapView, didSelectAnnotationView annotationView: MKAnnotationView)
    {
        
        //print("I'm calling didSelectAnnotationView with origin of x: %f y:%f", annotationView.frame.origin.x, annotationView.frame.origin.y)
        let pin = annotationView.annotation
        mapView.deselectAnnotation(pin, animated: false)
        
        
    var width = self.view.frame.width / 3
    if(self.view.frame.height > self.view.frame.width) {
    width = self.view.frame.height / 3
    }
    let annView = annotationView.annotation as? City;

        
    let aView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))
    print(width)
    
    let imageName = (annView!.image)
    let image = UIImage(named: imageName)
    let imageView = UIImageView(image: image)
    
    imageView.frame = CGRect(x: 0, y: 0, width: width, height: width/2)
    aView.addSubview(imageView)
    
    let label = UILabel(frame: CGRect(x:0, y:width/2 + 3, width: width, height: width/2-3))
    label.text = (annView!.information)
    label.numberOfLines = 0
    label.textAlignment = NSTextAlignment.Center
    //label.font = label.font.fontWithSize(12)
        label.adjustsFontSizeToFitWidth = true
        aView.addSubview(label);
    var options:[PopoverOption]
    
    if(annotationView.frame.origin.y - width < 15) {
    options = [
    .Type(.Down),
    .AnimationIn(0.3),
    .ArrowSize(CGSize(width: 15.0, height: 15.0))
    ] as [PopoverOption]
    
    } else {
    options = [
    .Type(.Up),
    .AnimationIn(0.3),
    .ArrowSize(CGSize(width: 15.0, height: 15.0))
    ] as [PopoverOption]
    }
    
    let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
    
    print("AnnotationView x origin: ", annotationView.frame.origin.x)
    print("AnnotationView y origin: ", annotationView.frame.origin.y)
    
    popover.show(aView, fromView: annotationView)
    
}

    
    
    
    
    
    func mapView(mapView: MKMapView,
                 didAddAnnotationViews views: [MKAnnotationView]) {
        //[mapView selectAnnotation:[[mapView annotations] lastObject] animated:YES];

        //mapView.selectAnnotation(mapView.annotations.last!, animated: true)
        //print("View coordinates: x: %f y:%f", views[0].frame.origin.x, views[0].frame.origin.x)
        
        
    }
    
}