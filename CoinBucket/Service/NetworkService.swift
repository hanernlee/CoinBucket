//
//  NetworkService.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation
import Alamofire

enum NetworkResult<T> {
    case Success(T)
    case Error(Error)
}

protocol Gettable {
    associatedtype T
//    func get(_ url: String, completion: @escaping (Result<T>) -> Void)
    func getAllCoins(completion: @escaping (NetworkResult<T>) -> Void)
}

public struct NetworkService: Gettable {
    private let decoder = JSONDecoder()
    
    func getAllCoins(completion: @escaping (NetworkResult<[Coin]>) -> Void) {
        guard let url = URL(string: API.all) else { return }
        
        Alamofire.request(url).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Handle Error Please: \(error)")
            }
            
            guard let data = dataResponse.data else {
                print("no daata")
                return
            }
            
            do {
                let result = try self.decoder.decode(Result.self, from: data)
                var coins = [Coin]()
                for (_, value) in result.data {
                    coins.append(value)
                }
                
                coins = coins.sorted(by: { Int($0.sortOrder)! < Int($1.sortOrder)! })

                completion(.Success(coins))
            }
            catch let decodeError {
                print("Failed to decode, Handle Error here: \(decodeError)")
            }
        }
    }
}
