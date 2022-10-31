//
//  HotelDetailView.swift
//  HotelSearch
//
//  Created by Khateeb Hussain on 10/31/22.
//

import UIKit
import MapKit

class HotelDetailView: UIView {
    var model: LocationItem? {
        didSet {
            self.shortLabel.text = "Name: \(model?.regionNames.shortName ?? "")"
            self.fullLabel.text = "Full name:\n\(model?.regionNames.fullName ?? "")"
            self.addressLabel.text = "Address:\n\(model?.hotelAddress?.fullAddress() ?? "")"
            
            guard let coordinates = model?.coordinates,
                  let latitude = Double(coordinates.lat),
                  let longitude = Double(coordinates.long) else {
                return
            }
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = .init(latitude: latitude, longitude: longitude)
            self.mapView.addAnnotation(annotation)
        }
    }

    let shortLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fullLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [shortLabel, fullLabel, addressLabel, mapView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
        ])
    
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
