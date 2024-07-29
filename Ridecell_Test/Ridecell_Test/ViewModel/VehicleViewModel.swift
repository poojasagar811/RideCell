//
//  VehicleViewModel.swift
//  Ridecell_Test
//
//  Created by apple on 28/07/24.
//

import Foundation
import UIKit
import MapKit

class VehicleViewModel {
    var vehicles: [Vehicle] = []
    func loadVehicles(from jsonFile: String) {
            guard let url = Bundle.main.url(forResource: jsonFile, withExtension: "json"),
                  let data = try? Data(contentsOf: url) else { return }
            
            let decoder = JSONDecoder()
            self.vehicles = (try? decoder.decode([Vehicle].self, from: data)) ?? []
        }
        
        func numberOfVehicles() -> Int {
            return vehicles.count
        }
        
        func vehicle(at index: Int) -> Vehicle {
            return vehicles[index]
        }
        
    func annotations() -> [VehicleAnnotation] {
        return vehicles.map { VehicleAnnotation(vehicle: $0) }

        }
        
        func vehicle(for annotation: MKAnnotation) -> Vehicle? {
            return vehicles.first { vehicle in
                vehicle.lat == annotation.coordinate.latitude && vehicle.lng == annotation.coordinate.longitude
            }
        }
    }
