//
//  CoinPrice.swift
//  CoinBucket
//
//  Created by Christopher Lee on 29/10/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

struct CoinPrice {
    let displayPrice: CoinPriceDisplay
    let displayPriceBTC: CoinPriceDisplay
    
    init(displayPrice: CoinPriceDisplay, displayPriceBTC: CoinPriceDisplay) {
        self.displayPrice = displayPrice
        self.displayPriceBTC = displayPriceBTC
    }
}
