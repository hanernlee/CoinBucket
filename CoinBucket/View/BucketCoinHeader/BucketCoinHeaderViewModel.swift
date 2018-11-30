//
//  BucketCoinHeaderViewModel.swift
//  CoinBucket
//
//  Created by Christopher Lee on 23/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

class BucketCoinHeaderViewModel {
    let count: Float
    let environmentService: EnvironmentServiceProtocol
    
    init(count: Float, environmentService: EnvironmentServiceProtocol) {
        self.count = count
        self.environmentService = environmentService
    }
    
    func configureTotalString(with count: Float) -> String {
        let formattedCount =  String(format: "%.2f", arguments: [count])
        return """
        Total
        \(environmentService.currency) $ \(formattedCount)
        """
    }
}
