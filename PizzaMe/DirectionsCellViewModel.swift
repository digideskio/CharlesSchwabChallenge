//
//  DirectionsCellViewModel.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

// MARK: - DirectionsCellViewModel

class DirectionsCellViewModel: DetailCellViewModel {
    
    // MARK: - Property Delcarations
    
    let address:   String
    let city:      String
    let state:     String
    let imageName: String = "map-icon"
    
    // MARK: - Initialization
    
    init(restaurant: Restaurant) {
        address = restaurant.address
        city    = restaurant.city
        state   = restaurant.state
    }
    
    override func getAction() -> String? {
        let destinationAddress = "\(address),\(city),\(state)".components(separatedBy: .whitespacesAndNewlines).joined(separator: "+")
        return "http://maps.apple.com/?daddr=\(destinationAddress)"
    }
    
}
