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

extension ViewController: MKMapViewDelegate {
    
    func buttonAction() ->String {
        return "hello world"
    }
    
    // 1
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? City {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
            
                view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
    
    
    func mapView(mapView: MKMapView, annotationView: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let annView = annotationView.annotation as? City;
        print("Information: " + annView!.information);
        print("Image: %s", annView!.image);

        if control == annotationView.rightCalloutAccessoryView {
            let width = self.view.frame.width / 3
            let aView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))
            
            
            let imageName = (annView!.image)
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image)
            
            imageView.frame = CGRect(x: 0, y: 0, width: width, height: width/2)
            aView.addSubview(imageView)
            
            let label = UILabel(frame: CGRect(x:0, y:width/4, width: width, height: width))
            label.text = (annView!.information)
            label.numberOfLines = 0
            label.textAlignment = NSTextAlignment.Center
            label.font = label.font.fontWithSize(12)
            
            aView.addSubview(label);
            let options = [
                .Type(.Up),
                //.CornerRadius(width / 2),
                .AnimationIn(0.3),
                .ArrowSize(CGSize(width: 15.0, height: 15.0))
                ] as [PopoverOption]
            let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
            popover.show(aView, fromView: annotationView)
        }
    }
}