//
//  PriceResult.swift
//  CoinBucket
//
//  Created by Christopher Lee on 2/10/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

struct PriceResult: Codable {
    let rawData: [String: [String: RawPriceData]]
    let displayData: [String: [String: DisplayPriceData]]
    
    private enum CodingKeys: String, CodingKey {
        case rawData = "RAW"
        case displayData = "DISPLAY"
    }
}
