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
    
    init(restaurantList: Array<Restaurant>) { // TODO: MOVE THIS ELSEWHERE
        self.restaurantList = restaurantList.sorted { $0.distance < $1.distance }
    }
}

extension RestaurantListViewModel {
    func restaurant(indexPath: IndexPath) -> Restaurant? {
        return indexPath.row < restaurantList.count ? restaurantList[indexPath.row] : nil
    }
}
