//
//  CoinPriceData.swift
//  CoinBucket
//
//  Created by Christopher Lee on 2/10/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

struct CoinPriceData: Codable {
    let rawPriceData: [String: RawPriceData]
    let displayPriceData: [String: DisplayPriceData]
    
    init(rawPriceData: [String: RawPriceData], displayPriceData:[String: DisplayPriceData]) {
        self.rawPriceData = rawPriceData
        self.displayPriceData = displayPriceData
    }
}
