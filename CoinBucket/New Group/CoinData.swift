//
//  CoinData.swift
//  CoinBucket
//
//  Created by Christopher Lee on 22/10/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

struct CoinData: Codable {
    let coin: Coin
    let conversionInfo: ConversionInfo?
    
    private enum CodingKeys : String, CodingKey {
        case coin = "CoinInfo"
        case conversionInfo = "ConversionInfo"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        coin = try container.decode(Coin.self, forKey: .coin)
        conversionInfo = try container.decodeIfPresent(ConversionInfo.self, forKey: .conversionInfo)
    }
}
