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
    let imageID: String
    let priceBTC: String
    let percentChange24h: String?
    let price: String
    let marketCap: String?
    let currency: String
    let availableSupply: String
    let volume: String
    
    var imageUrl: String {
        return "https://s2.coinmarketcap.com/static/img/coins/32x32/\(imageID).png"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case symbol = "symbol"
        case imageID = "image_id"
        case priceBTC = "price_btc"
        case percentChange24h = "percent_change_24h"
        case price = "price"
        case marketCap = "market_cap"
        case currency = "currency"
        case availableSupply = "available_supply"
        case volume = "volume_24h"
    }
}
