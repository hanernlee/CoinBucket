//
//  Currency.swift
//  CoinBucket
//
//  Created by Christopher Lee on 4/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

struct Currency {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

struct Currencies: Decodable {
    let currencies: [String]
    
    private enum CodingKeys: String, CodingKey {
        case currencies
    }
    
    static func getCurrencies() -> [String]? {
        guard let url = Bundle.main.url(forResource: "Currencies", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        do {
            let response = try JSONDecoder().decode(Currencies.self, from: data)

            return response.currencies
        } catch let error{
            print("Failed to decode currencies: \(error)")
            return nil
        }
    }
}
