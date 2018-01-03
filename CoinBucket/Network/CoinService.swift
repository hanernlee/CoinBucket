//
//  CoinService.swift
//  CoinBucket
//
//  Created by Christopher Lee on 12/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation

protocol Gettable {
    associatedtype T
    func get(completion: @escaping (Result<T>) -> Void)
}

struct CoinService: Gettable {
    var id: String?
    var start: Int
    var convert: String
    
    let downloader = JSONDownloader()
    typealias completionHandler = (Result<[Coin?]>) -> ()

    func get(completion: @escaping completionHandler) {
        let baseURL = "https://coinster.herokuapp.com/"
        var path: String
        
        if let id = id {
            path = "coin?id=\(id)"
        } else {
            path = "coins?start=\(start)"
        }
        
        let endpoint = baseURL + path + "&currency=\(convert)"
        
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
