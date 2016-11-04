//
//  WebSiteCellViewModel.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

// MARK: - WebSiteCellViewModel

final class WebSiteCellViewModel: DetailCellViewModel {
    
    // MARK: - Property Delcarations
    
    let webSite:   String
    let imageName: String = "icon-website"
    
    // MARK: - Initialization
    
    init(restaurant: Restaurant) {
        webSite = restaurant.businessURL
    }
    
    override var action: String? {
        return webSite
    }
}
