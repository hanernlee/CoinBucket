//
//  TallyViewViewModel.swift
//  CoinBucket
//
//  Created by Christopher Lee on 18/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

class TallyViewViewModel {
    let coin: Coin
    var environmentService: EnvironmentServiceProtocol
    
    var initialCount: Float = 0
    
    var coinName: String {
        return coin.name
    }
    
    init(coin: Coin, environmentService: EnvironmentServiceProtocol) {
        self.coin = coin
        self.environmentService = environmentService

        self.initialCount = environmentService.bucket[coin.name] ?? 0
    }
    
    func increaseCount() {
        initialCount += 1
    }
    
    func decreaseCount() {
        guard initialCount - 1 > 0 else {
            return initialCount = 0
        }

        initialCount -= 1
    }
    
    func saveCount() {
        environmentService.bucket[coin.name] = initialCount
    }
    
    func resetCount() {
        guard let count = environmentService.bucket[coin.name] else {
            return initialCount = 0
        }
        initialCount = count
    }
}
