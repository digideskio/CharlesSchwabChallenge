//
//  RestaurantCellViewModel.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

// MARK: - RestaurantCellViewModel

struct RestaurantCellViewModel {
    let name:        String
    let address:     String
    let cityState:   String
    let phoneNumber: String
    let distance:    Double
}

// MARK: - Initialization

extension RestaurantCellViewModel {
    init(restaurant: Restaurant) {
        name        = restaurant.name
        distance    = restaurant.distance
        cityState   = restaurant.city + ", " + restaurant.state
        address     = restaurant.address
        phoneNumber = restaurant.phone
    }
}
