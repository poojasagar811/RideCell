//
//  VehicleAnnnotation.swift
//  Ridecell_Test
//
//  Created by apple on 28/07/24.
//

import Foundation
import MapKit

class VehicleAnnotation: NSObject, MKAnnotation {
    let vehicle: Vehicle
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
        
        init(vehicle: Vehicle) {
            self.vehicle = vehicle
            
            let latitude = vehicle.lat ?? 0.0
            let longitude = vehicle.lng ?? 0.0 
           
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            self.title = vehicle.vehicleMake
            self.subtitle = vehicle.licensePlateNumber
        }
}
