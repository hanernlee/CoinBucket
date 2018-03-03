//
//  CoinViewModel.swift
//  CoinBucket
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
    let priceBTC: String
    let percentChange24h: Double
    let price: NSDecimalNumber
    let marketCap: NSDecimalNumber
    
    init(model: Coin) {
        self.id = model.id
        self.name = model.name
        self.symbol = model.symbol
        self.imageUrl = model.imageUrl
        self.priceBTC = model.priceBTC
        self.percentChange24h = (model.percentChange24h != nil) ? (model.percentChange24h! as NSString).doubleValue : Double(0.00)
        self.price = NSDecimalNumber(string: model.price)
        self.marketCap = (model.marketCap != nil) ? NSDecimalNumber(string: model.marketCap) : NSDecimalNumber(string: "0")
    }
}
