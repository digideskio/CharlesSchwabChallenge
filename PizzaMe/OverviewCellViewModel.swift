//
//  OverviewCellViewModel.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

// MARK: - OverviewCellViewModel

final class OverviewCellViewModel: DetailCellViewModel {
    
    // MARK: - Property Delcarations
    
    let name:     String
    let distance: String
    
    // MARK: - Initialization
    
    init(restaurant: Restaurant) {
        name     = restaurant.name
        distance = "\(restaurant.distance) mile(s)"
    }
}
