//
//  SearchServiceResponse.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

// MARK: - SearchServiceResponseKeys

struct SearchServiceResponseKeys {
    static let query   = "query"
    static let results = "results"
    static let result  = "Result"
}

// MARK: - SearchServiceResponse

final class SearchServiceResponse {
    
    // MARK: - Property Delcarations
    
    let restaurantList: Array<Restaurant>
    
    // MARK: - Initialization
    
    init?(response: [String: AnyObject]?) {
        guard let response = response,
              let query    = response[SearchServiceResponseKeys.query],
              let results  = query[SearchServiceResponseKeys.results]  as? [String: AnyObject],
              let result   = results[SearchServiceResponseKeys.result] as? [[String: AnyObject]] else { return nil }
        restaurantList = result.flatMap(Restaurant.init)
    }
}
