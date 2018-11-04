//
//  Coin.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

class Coin: Codable {
    let id: String
    let name: String
    let fullName: String
    let imageUrl: String
    
    private enum CoinResponseKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case fullName = "FullName"
        case imageUrl = "ImageUrl"
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CoinResponseKeys.self)
    
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? "https://via.placeholder.com/350x150"
    }
}
