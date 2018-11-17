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
    let marketCap: String
    let supply: String
    let volume24H: String
    let volume24HTO: String
    let totalVolume24H: String
    let totalVolume24HTO: String
    let priceOpen24Hour: String
    let priceHigh24Hour: String
    let priceLow24Hour: String
    
    private enum CodingKeys: String, CodingKey {
        case price = "PRICE"
        case changePercent24Hour = "CHANGEPCT24HOUR"
        case marketCap = "MKTCAP"
        case supply = "SUPPLY"
        case volume24H = "VOLUME24HOUR"
        case volume24HTO = "VOLUME24HOURTO"
        case totalVolume24H = "TOTALVOLUME24H"
        case totalVolume24HTO = "TOTALVOLUME24HTO"
        case priceOpen24Hour = "OPEN24HOUR"
        case priceHigh24Hour = "HIGH24HOUR"
        case priceLow24Hour = "LOW24HOUR"
    }
}
