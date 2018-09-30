//
//  Coin.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

struct Coin: Codable {
    let id: String
    let sortOrder: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "Id"
        case sortOrder = "SortOrder"
    }
}
