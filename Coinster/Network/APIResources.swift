////
////  APIResources.swift
////  Coinster
////
////  Created by Christopher Lee on 10/12/17.
////  Copyright © 2017 Christopher Lee. All rights reserved.
////
//
//import Foundation
//
//protocol APIResource {
//    associatedtype Model: Decodable
//    var methodPath: String { get }
//    func makeModel(data: Data) -> Model
//}
//
//extension APIResource {
//    var url: URL {
//        let baseUrl = "https://api.coinmarketcap.com/v1/"
//        let limit = "10"
//        let url = baseUrl + methodPath + "?limit=" + limit
//        return URL(string: url)!
//    }
//    
//    func makeModel(data: Data) -> [Model]? {
//        let decoder = JSONDecoder()
//
//        do {
//            let results = try decoder.decode([Model].self, from: data)
//            return results
//        } catch {
//            print("Failed to decode coins:", error)
//            return []
//        }
//    }
//}
//
//struct CoinsResource: APIResource {
//    let methodPath = "/ticker/"
//
//    func makeModel(data: Data) -> Coin {
//        return Coin(id: "", name: "", symbol: "", price_usd: "", price_btc: "", market_cap_usd: "", percent_change_24h: "")
//    }
//}

