//
//  AddressCellViewModel.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

// MARK: - AddressCellViewModel

final class AddressCellViewModel: DetailCellViewModel {
    
    // MARK: - Property Delcarations
    
    let imageName: String = "address-image"
    let address:   String
    let cityState: String
    let longitude: Double
    let latitude:  Double
    
    // MARK: - Initialization
    
    init(restaurant: Restaurant) {
        address   = restaurant.address
        cityState = restaurant.city + ", " + restaurant.state
        longitude = restaurant.longitude
        latitude  = restaurant.latitude
    }
    
    override var action: String? {
        return "http://maps.apple.com/?ll=\(latitude),\(longitude)"
    }
}
