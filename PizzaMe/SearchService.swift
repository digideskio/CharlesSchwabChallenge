//
//  SearchService.swift
//  PizzaMe
//
//  Copyright © 2016 Charles Schwab & Co., Inc. All rights reserved.
//

import Foundation

typealias SearchServiceCompletionHandler = (_ response: SearchServiceResponse?, _ error: Error?) -> Void

// MARK: - SearchService

final class SearchService {
    
    func results(for zipCode: String, completion: @escaping SearchServiceCompletionHandler) {
        let servicePath = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20local.search%20where%20zip%3D%27\(zipCode)%27%20and%20query%3D%27pizza%27&format=json&diagnostics=false&callback=" // FIXME: MOVE THIS ELSEWHERE
        guard let url = URL(string: servicePath) else { return }
        URLSession(configuration: URLSessionConfiguration.default).dataTask(with: url) { data, response, dataTaskError in
            guard let data = data, (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(nil, dataTaskError)
                return
            }
            do {
                let json  = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject]
                let searchServiceResponse = SearchServiceResponse(response: json.flatMap { $0 })
                completion(searchServiceResponse, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
