//
//  CoinPriceResult.swift
//  CoinBucket
//
//  Created by Christopher Lee on 29/10/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

struct CoinPriceResult: Decodable {
    let display: [String: [String: CoinPriceDisplay]]
    
    private enum CodingKeys: String, CodingKey {
        case display = "DISPLAY"
    }
}

struct CoinPriceDisplay: Decodable{
    let price: String
    let changePercent24Hour: String
    
    private enum CodingKeys: String, CodingKey {
        case price = "PRICE"
        case changePercent24Hour = "CHANGEPCT24HOUR"
    }
}
