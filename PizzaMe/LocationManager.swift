//
//  LocationManager.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation
import CoreLocation

// MARK: - LocationManagerDelegate

protocol LocationManagerDelegate: class {
    func didUpdate(zipCode: String)
    func didFail(error: Error)
}

// MARK: - LocationManager

final class LocationManager: NSObject {
    
    // MARK: - Property Delcarations
    
    private let locationManager: CLLocationManager
    weak var delegate: LocationManagerDelegate?    
    
    // MARK: - Initialization
    
    fileprivate override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func updateLocation() {
        locationManager.startUpdatingLocation()
    }    
}

// MARK: - LocationManager Singleton

extension LocationManager {
    static let sharedInstance = LocationManager()
}

// MARK: - CLLocationManagerDelegate Conformance

extension LocationManager: CLLocationManagerDelegate {
    private func locationManager(_ manager: CLLocationManager, didFailWithError error: NSError) { // // FIXME: WHAT IS THIS????
        manager.stopUpdatingLocation()
        self.delegate?.didFail(error: error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        manager.stopUpdatingLocation()
        CLGeocoder().reverseGeocodeLocation(currentLocation) { placemarks, error in
            guard let postalCode = placemarks?.first?.postalCode else {
                guard let error = error else { return }
                self.delegate?.didFail(error: error)
                return
            }
            self.delegate?.didUpdate(zipCode: postalCode)
        }
    }
}
