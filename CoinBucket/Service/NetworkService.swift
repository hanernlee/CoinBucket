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
    func getCoins(page: Int, currency: String, completion: @escaping (NetworkResult<[ConstructedCoin]>) -> Void)
    func getCoin(symbol: String, currency: String, completion: @escaping (NetworkResult<[ConstructedCoin]>) -> Void)
    func getPrices(symbols: String, currency: String, completion: @escaping (NetworkResult<CoinPriceResult>) -> Void)
    func getSuggestions(searchText: String, completion: @escaping (NetworkResult<[Suggestion]>) -> Void)

}

public struct NetworkService: Gettable {
    private let decoder = JSONDecoder()
    
    func getCoins(page: Int, currency: String, completion: @escaping (NetworkResult<[ConstructedCoin]>) -> Void) {
        guard let url = URL(string: APIClient.getCoins(page: page, currency: currency)) else { return }

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

                let coinSymbols = result.data.map({ $0.coin.name }).joined(separator: ",")
                let coins = result.data.map({ $0.coin })

                var constructedCoins = [ConstructedCoin]()
                
                self.getPrices(symbols: coinSymbols, currency: currency, completion: { result in
                    switch result {
                    case .Success(let coinPrices):
                        coins.forEach {
                            guard let price = coinPrices.display[$0.name] else { return }
                            let constructedCoin = ConstructedCoin(coin: $0, price: price)
                            constructedCoins.append(constructedCoin)
                        }

                        completion(.Success(constructedCoins))
                    case .Error:
                        print("Failed")
                    }
                })
            }
            catch let decodeError {
                print("Failed to decode, Handle Error here: \(decodeError)")
            }
        }
    }
    
    func getCoin(symbol: String, currency: String, completion: @escaping (NetworkResult<[ConstructedCoin]>) -> Void) {
        guard let url = URL(string: APIClient.getCoin(symbol: symbol, currency: currency)) else { return }
        
        Alamofire.request(url).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Handle Error Please: \(error)")
            }
            
            guard let data = dataResponse.data else {
                print("No data")
                return
            }
            
            do {
                let result = try self.decoder.decode(Result.self, from: data)
                
                let coinSymbols = result.data.map({ $0.coin.name }).joined(separator: ",")
                let coins = result.data.map({ $0.coin })
                
                var constructedCoins = [ConstructedCoin]()
                
                self.getPrices(symbols: coinSymbols, currency: currency, completion: { result in
                    switch result {
                    case .Success(let coinPrices):
                        coins.forEach {
                            guard let price = coinPrices.display[$0.name] else { return }
                            let constructedCoin = ConstructedCoin(coin: $0, price: price)
                            constructedCoins.append(constructedCoin)
                        }

                        completion(.Success(constructedCoins))
                    case .Error:
                        print("Failed")
                    }
                })
            }
            catch let decodeError {
                print("Failed to decode, Handle Error here: \(decodeError)")
            }
        }
    }
    
    func getPrices(symbols: String, currency: String, completion: @escaping (NetworkResult<CoinPriceResult>) -> Void) {
        guard let url = URL(string: APIClient.getPrices(symbols, currency: currency)) else { return }

        Alamofire.request(url).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Handle Error Please: \(error)")
            }
            
            guard let data = dataResponse.data else {
                print("no daata")
                return
            }
            
            do {
                let result = try self.decoder.decode(CoinPriceResult.self, from: data)
                completion(.Success(result))
            }
            catch let decodeError {
                print("Failed to decode, Handle Error here: \(decodeError)")
            }
        }
    }
    
    func getSuggestions(searchText: String, completion: @escaping (NetworkResult<[Suggestion]>) -> Void) {
        guard let url = URL(string: APIClient.getSuggestions(searchText)) else { return }
        
        Alamofire.request(url).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Handle Error Please: \(error)")
            }
            
            guard let data = dataResponse.data else {
                print("no daata")
                return
            }
            
            do {
                let result = try self.decoder.decode(SuggestionResult.self, from: data)
                let suggestions = result.result.filter({ $0.group == "Coins" })
                completion(.Success(suggestions))
            }
            catch let decodeError {
                print("Failed to decode, Handle Error here: \(decodeError)")
            }
        }
    }
}
