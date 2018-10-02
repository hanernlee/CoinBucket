//
//  APIStruct.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

public struct API {
    static let baseUrl = "https://www.cryptocompare.com"
    static let dataUrl = "https://min-api.cryptocompare.com/data"
    
    static func getAll() -> String {
        return "\(dataUrl)/all/coinlist"
    }
    
    static func getPriceData(_ symbol: String) -> String {
        return "\(dataUrl)/pricemultifull?fsyms=\(symbol)&tsyms=USD,BTC"
    }
}
