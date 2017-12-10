//
//  Coin.swift
//  Coinster
//
//  Created by Christopher Lee on 9/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation

struct Coin: Codable {
    let id: String
    let name: String
    let symbol: String
    let price_usd: String
    let price_btc: String
    let market_cap_usd: String
    let percent_change_24h: String
    
    init(id: String, name: String, symbol: String, price_usd: String, price_btc: String, market_cap_usd: String, percent_change_24h: String) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.price_usd = price_usd
        self.price_btc = price_btc
        self.market_cap_usd = market_cap_usd
        self.percent_change_24h = percent_change_24h
    }
}
