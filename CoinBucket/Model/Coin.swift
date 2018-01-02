//
//  Coin.swift
//  CoinBucket
//
//  Created by Christopher Lee on 9/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation

struct Coin: Codable {
    let id: String
    let name: String
    let symbol: String
    let priceUSD: String
    let priceBTC: String
    let marketCapUSD: String?
    let percentChange24h: String?
    let price: String
    let marketCap: String?
    
    var imageUrl: String {
        return "https://files.coinmarketcap.com/static/img/coins/32x32/\(id).png"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case symbol = "symbol"
        case priceUSD = "price_usd"
        case priceBTC = "price_btc"
        case marketCapUSD = "market_cap_usd"
        case percentChange24h = "percent_change_24h"
        case price = "price"
        case marketCap = "market_cap"
    }
}
