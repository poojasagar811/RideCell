//
//  VehicleCollectionViewCell.swift
//  Ridecell_Test
//
//  Created by apple on 28/07/24.
//

import UIKit

class VehicleCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "VehicleCell"
    
    @IBOutlet weak var amountLabel: UILabel?
    
    @IBOutlet weak var parkingPrice: UILabel?
    
    @IBOutlet weak var carImage: UIImageView?
    @IBOutlet weak var nameLabel: UILabel?
    
    @IBOutlet weak var betteryLabel: UILabel?
    let imageView = UIImageView()
    let titleLabel = UILabel()
    
    
    func configure(with vehicle: Vehicle) {
        amountLabel?.text = vehicle.vehicleMake
        parkingPrice?.text = vehicle.licensePlateNumber
        nameLabel?.text = vehicle.transmissionMode
        if let vehicleTypeID = vehicle.vehicleTypeID {
            betteryLabel?.text = String(vehicleTypeID)
        } else {
            betteryLabel?.text = "N/A"
        }
        
        
        
        if let urlString = vehicle.vehiclePicAbsoluteURL, let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    DispatchQueue.main.async {
                        self.carImage?.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
    
}
