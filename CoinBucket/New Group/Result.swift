//
//  Result.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

struct Result: Codable {
    let message: String
    let data: [CoinData]
    
    private enum CodingKeys: String, CodingKey {
        case message = "Message"
        case data = "Data"
    }
}
