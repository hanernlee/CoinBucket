//
//  APIClient.swift
//  CoinBucket
//
//  Created by Christopher Lee on 4/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

public struct APIClient {
    static let apiUrl: String =  "https://min-api.cryptocompare.com"
    static let baseUrl: String = "https://cryptocompare.com"

    static func getCoins(page: Int = 0, currency: String) -> String {
        return "\(apiUrl)/data/top/totalvol?limit=50&page=\(page)&tsym=\(currency)"
    }
    
    static func getPrices(_ symbols: String, currency: String) -> String {
        return "\(apiUrl)/data/pricemultifull?fsyms=\(symbols)&tsyms=\(currency),BTC"
    }
    
    static func getSuggestions(_ searchText: String) -> String {
        return "\(baseUrl)/api/autosuggest/all/?maxRows=10&q=\(searchText)"
    }
    
    static func getCoin(symbols: String, currency: String) -> String {
        return "\(apiUrl)/data/coin/generalinfo?fsyms=\(symbols)&tsym=\(currency)"
    }
}
