//
//  RawPriceData.swift
//  CoinBucket
//
//  Created by Christopher Lee on 2/10/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

struct RawPriceData: Codable {
    let price: Float
    
    private enum CodingKeys: String, CodingKey {
        case price = "PRICE"
    }
}
