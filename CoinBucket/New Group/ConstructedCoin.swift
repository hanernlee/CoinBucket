//
//  ConstructedCoin.swift
//  CoinBucket
//
//  Created by Christopher Lee on 30/10/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

struct ConstructedCoin {
    let coin: Coin
    let price: [String: CoinPriceDisplay]
    
    init(coin: Coin, price: [String: CoinPriceDisplay]) {
        self.coin = coin
        self.price = price
    }
}
