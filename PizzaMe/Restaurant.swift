//
//  Restaurant.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

struct RestaurantKey {
    static let title       = "Title"
    static let address     = "Address"
    static let city        = "City"
    static let state       = "State"
    static let phone       = "Phone"
    static let distance    = "Distance"
    static let businessURL = "BusinessUrl"
    static let latitude    = "Latitude"
    static let longitude   = "Longitude"
}

// MARK: - Restaurant

struct Restaurant {
    let name:        String
    let address:     String
    let city:        String
    let state:       String
    let phone:       String
    let distance:    Double
    let businessURL: String
    let latitude:    Double
    let longitude:   Double
    
    init?(restaurant: [String: AnyObject]) {
        guard let name            = restaurant[RestaurantKey.title]       as? String,
              let address         = restaurant[RestaurantKey.address]     as? String,
              let city            = restaurant[RestaurantKey.city]        as? String,
              let state           = restaurant[RestaurantKey.state]       as? String,
              let phone           = restaurant[RestaurantKey.phone]       as? String,
              let businessURL     = restaurant[RestaurantKey.businessURL] as? String,
              let distanceString  = restaurant[RestaurantKey.distance]    as? String,
              let latitudeString  = restaurant[RestaurantKey.latitude]    as? String,
              let longitudeString = restaurant[RestaurantKey.longitude]   as? String,
              let latitude        = Double(longitudeString),
              let longitude       = Double(latitudeString),
              let distance        = Double(distanceString) else { return nil }
        self.name        = name
        self.address     = address
        self.city        = city
        self.state       = state
        self.phone       = phone
        self.distance    = distance
        self.businessURL = businessURL
        self.latitude    = latitude
        self.longitude   = longitude
    }
}
