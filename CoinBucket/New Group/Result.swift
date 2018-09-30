//
//  Result.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

struct Result: Codable {
    let response: String
    let message: String
    let data: [String: Coin]
    
    private enum CodingKeys: String, CodingKey {
        case response = "Response"
        case message = "Message"
        case data = "Data"
    }
}
