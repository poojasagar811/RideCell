//
//  VehicleAnnotationView.swift
//  Ridecell_Test
//
//  Created by apple on 28/07/24.
//

import Foundation
import MapKit

class VehicleAnnotationView : MKAnnotationView{
    
        override var annotation: MKAnnotation? {
            willSet {
                guard let vehicleAnnotation = newValue as? VehicleAnnotation else { return }
                
                canShowCallout = true
                calloutOffset = CGPoint(x: -5, y: 5)
                rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                image = UIImage(named: "location") 
                
                
                // Custom detail callout view
                let detailLabel = UILabel()
                detailLabel.numberOfLines = 2
               // detailLabel.text = "\(vehicleAnnotation.title ?? "")\n\(vehicleAnnotation.subtitle ?? "")"
                detailCalloutAccessoryView = detailLabel
            }
        }
}
