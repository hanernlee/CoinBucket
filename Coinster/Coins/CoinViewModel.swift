//
//  CoinViewModel.swift
//  Coinster
//
//  Created by Christopher Lee on 12/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation

struct CoinViewModel {
    let id: String
    let name: String
    let symbol: String
    let imageUrl: String
    let price_usd: String
    let price_btc: String
    let market_cap_usd: String
    let percent_change_24h: String
    
    init(model: Coin) {
        self.id = model.id
        self.name = model.name
        self.symbol = model.symbol
        self.imageUrl = model.imageUrl
        self.price_usd = model.price_usd
        self.price_btc = model.price_btc
        self.market_cap_usd = model.market_cap_usd
        self.percent_change_24h = model.percent_change_24h
    }
}
