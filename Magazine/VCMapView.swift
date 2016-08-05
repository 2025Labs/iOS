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

        print(annotationView)
        let pin = annotationView.annotation
        mapView.deselectAnnotation(pin, animated: false)
        
        
    var width = self.view.frame.width / 2.5
    if(self.view.frame.height > self.view.frame.width) {
    width = self.view.frame.height / 2.5
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
    
        popover.show(aView, fromView: annotationView)
}
    
        /*
    func mapViewDidFinishLoadingMap(mapView: MKMapView) {
        //self.displayPopover()
    }
    

    func displayPopover() {
        
        print("displayPopover")
        let width = self.view.frame.width;
        let height = self.view.frame.height;
        let aView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width/6))
        print(width)
        

        let label = UILabel(frame: CGRect(x:0, y:width/2 + 3, width: width, height: height))
        label.text = "This is a test"
        label.textAlignment = NSTextAlignment.Center
        //label.font = label.font.fontWithSize(12)
        label.adjustsFontSizeToFitWidth = true
        aView.addSubview(label);
        var options:[PopoverOption]

        options = [
            .Type(.Down),
            .AnimationIn(0.3),
            .ArrowSize(CGSize(width: 15.0, height: 15.0))
            ] as [PopoverOption]
        let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
        
        //popover.show(aView, fromView: SomeClass.Static.items.first!)
 
    }
    func mapView(mapView: MKMapView,
                   didAddAnnotationViews views: [MKAnnotationView]) {
        for ann in mapView.annotations {
            if(ann.title! == "Bangalore"){
            mapView.selectAnnotation(ann,animated: true);
        }
        }
        print("called did add annotation views")
    }
    */
}