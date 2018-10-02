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
    func getAllCoins(completion: @escaping (NetworkResult<[Coin]>) -> Void)
    func getCoinPriceData(symbol: String, completion: @escaping (NetworkResult<CoinPriceData>) -> Void)
}

public struct NetworkService: Gettable {
    private let decoder = JSONDecoder()
    
    func getAllCoins(completion: @escaping (NetworkResult<[Coin]>) -> Void) {
        guard let url = URL(string: API.getAll()) else { return }
        
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
    
    func getCoinPriceData(symbol: String, completion: @escaping (NetworkResult<CoinPriceData>) -> Void) {
        
        guard let url = URL(string: API.getPriceData(symbol)) else { return }
        
        Alamofire.request(url).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Handle Error Please: \(error)")
            }
            
            guard let data = dataResponse.data else {
                print("no daata")
                return
            }

            do {
                let result = try self.decoder.decode(PriceResult.self, from: data)
                
                guard let rawPriceData = result.rawData[symbol], let displayPriceData = result.displayData[symbol] else {
                        print("Failed to downcast price data")
                        return
                }
                
                let coinPriceData = CoinPriceData(rawPriceData: rawPriceData, displayPriceData: displayPriceData)
               print(coinPriceData)
                completion(.Success(coinPriceData))
            }
            catch let decodeError {
                print("Failed to decode, Handle Error here: \(decodeError)")
            }
        }
        
    }
}
