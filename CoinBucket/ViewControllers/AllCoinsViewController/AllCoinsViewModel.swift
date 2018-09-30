//
//  AllCoinsViewModel.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

public class AllCoinsViewModel {
    private let environmentService: EnvironmentServiceProtocol
    private let networkService: NetworkService
    private var coins = [Coin]()
    
    init (environmentService: EnvironmentServiceProtocol, networkService: NetworkService) {
        self.environmentService = environmentService
        self.networkService = networkService
    }
    
    func getAllCoins() -> [Coin] {
        networkService.getAllCoins { result in
            switch result {
            case .Success(let coins):
                self.coins = coins
            case .Error:
                print("Failed")
            }
        }
        return coins
    }
}
