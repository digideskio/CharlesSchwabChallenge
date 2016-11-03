//
//  DetailViewModel.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

// MARK: - DetailCellType

enum DetailCellType: Int {
    case overview, directions, phone, website, address
    
    var cellIdentifier: String {
        switch self {
        case .overview:   return "OverviewCell"
        case .directions: return "DirectionsCell"
        case .phone:      return "PhoneCell"
        case .website:    return "WebSiteCell"
        case .address:    return "AddressCell"
        }
    }
}

// MARK: - DetailViewModel

final class DetailViewModel {
    
    // MARK: - Property Delcarations
    
    let title:          String = "Details"
    let availableCells: [DetailCellType] = [.overview, .directions, .phone, .website, .address]
    let restaurant:     Restaurant
    
    // MARK: - Initialization
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
    
    // MARK: - Instance Methods
    
    func cellViewModel(for indexPath: IndexPath) -> DetailCellViewModel? {
        guard let detailCellType = DetailCellType(rawValue: indexPath.row) else { return nil }
        switch detailCellType {
        case .overview:   return OverviewCellViewModel(restaurant: restaurant)
        case .directions: return DirectionsCellViewModel(restaurant: restaurant)
        case .phone:      return PhoneCellViewModel(restaurant: restaurant)
        case .website:    return WebSiteCellViewModel(restaurant: restaurant)
        case .address:    return AddressCellViewModel(restaurant: restaurant)
        }
    }
}

// MARK: - DetailCellViewModel

class DetailCellViewModel {
    func getAction() -> String? {
        return nil
    }
}


