//
//  APIResource.swift
//  Coinster
//
//  Created by Christopher Lee on 10/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation

protocol APIResource {
    associatedtype Model
    var methodPath: String { get }
    func makeModel(serialization: Data) -> Model
}

extension APIResource {
    var url: URL {
        let baseUrl = "https://api.coinmarketcap.com/v1"
        let limit = "limit=10"
        let url = baseUrl + methodPath + "?" + limit
        return URL(string: url)!
    }
    
    func makeModel(data: Data) -> [Model]? {
        return nil
    }
}

struct CoinsResource: APIResource {
    let methodPath = "/ticker/"
    
    func makeModel(serialization: Data) -> Coin {
        return Coin(name: "123")
    }
}
