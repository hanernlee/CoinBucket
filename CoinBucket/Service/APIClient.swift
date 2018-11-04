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

    static func getCoins(page: Int = 0, symbol: String = "USD") -> String {
        return "\(apiUrl)/data/top/totalvol?limit=50&page=\(page)&tsym=\(symbol)"
    }
    
    static func getPrices(_ symbols: String) -> String {
        return "\(apiUrl)/data/pricemultifull?fsyms=\(symbols)&tsyms=USD,BTC"
    }
}
