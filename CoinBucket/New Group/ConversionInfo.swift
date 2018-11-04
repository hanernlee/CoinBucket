//
//  ConversionInfo.swift
//  CoinBucket
//
//  Created by Christopher Lee on 22/10/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

struct ConversionInfo: Codable {
    let supply: Float
    let totalVolume24H: Float
    let raw: [String]
    
    private enum CodingKeys: String, CodingKey {
        case supply = "Supply"
        case totalVolume24H = "TotalVolume24H"
        case raw = "RAW"
    }
}
