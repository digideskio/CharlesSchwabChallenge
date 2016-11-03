//
//  RestaurantListViewModel.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

// MARK: - RestaurantListViewModel

struct RestaurantListViewModel {
    let restaurantList: Array<Restaurant>
}

// MARK: - Initialization

extension RestaurantListViewModel {
    init(restaurantList: [Restaurant], predicate: (Restaurant, Restaurant) -> Bool) {
        self.restaurantList = restaurantList.sorted(by: predicate)
    }
}

extension RestaurantListViewModel {
    func restaurant(indexPath: IndexPath) -> Restaurant? {
        return indexPath.row < restaurantList.count ? restaurantList[indexPath.row] : nil
    }
}
