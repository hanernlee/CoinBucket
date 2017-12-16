//
//  CoinService.swift
//  Coinster
//
//  Created by Christopher Lee on 12/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation

protocol Gettable {
    associatedtype T
    func get(id: String?, completion: @escaping (Result<T>) -> Void)
}

struct CoinService: Gettable {
    let downloader = JSONDownloader()
    typealias completionHandler = (Result<[Coin?]>) -> ()

    func get(id: String?, completion: @escaping completionHandler) {
        var endpoint = "https://api.coinmarketcap.com/v1/ticker/?limit=100"
        
        if let id = id {
            endpoint = "https://api.coinmarketcap.com/v1/ticker/\(id)"
        }
        
        guard let url = URL(string: endpoint) else {
            completion(.Error(.invalidURL))
            return
        }

        let request = URLRequest(url: url)
        let task = downloader.jsonTask(with: request) { (result) in

            DispatchQueue.main.async {
                switch result {
                case .Error(let error):
                    completion(.Error(error))
                case .Success(let json):
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode([Coin].self, from: json)
                        
                        completion(.Success(result))
                    } catch let error {
                        print("Failed to Parse Coins:", error)
                        completion(.Error(.jsonConversionFailure))
                    }
                }
            }
        }
        task.resume()
    }
}
