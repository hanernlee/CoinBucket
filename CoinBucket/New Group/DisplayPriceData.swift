//
//  DisplayPriceData.swift
//  CoinBucket
//
//  Created by Christopher Lee on 2/10/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

struct DisplayPriceData: Codable {
    let price: String
    
    private enum CodingKeys: String, CodingKey {
        case price = "PRICE"
    }
}
