//
//  VehicleMapViewController.swift
//  Ridecell_Test
//
//  Created by apple on 28/07/24.
//

import Foundation
import MapKit

class VehicleMapViewController: UIViewController, MKMapViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    private let viewModel = VehicleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "VehicleCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "VehicleCell")
        viewModel.loadVehicles(from: "Test -vehicles_data RT")
        setupMap()
    }
    
    private func setupMap() {
        let annotations = viewModel.vehicles.map { VehicleAnnotation(vehicle: $0) }
        mapView.addAnnotations(annotations)
        
        if let firstAnnotation = annotations.first {
            mapView.showAnnotations([firstAnnotation], animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? VehicleAnnotation else { return nil }
        
        let identifier = "VehicleAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? VehicleAnnotationView
        
        if annotationView == nil {
            annotationView = VehicleAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation,
              let vehicle = viewModel.vehicle(for: annotation) else { return }
        
        if let index = viewModel.vehicles.firstIndex(where: { $0.id == vehicle.id }) {
            collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

extension VehicleMapViewController:  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfVehicles()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VehicleCell", for: indexPath) as! VehicleCollectionViewCell
        let vehicle = viewModel.vehicle(at: indexPath.item)
        cell.configure(with: vehicle)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vehicle = viewModel.vehicle(at: indexPath.item)
        if let lat = vehicle.lat, let lng = vehicle.lng {
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            mapView.setCenter(coordinate, animated: true)
        }
    }
    
}
