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
    
    func getAllCoins(completion: @escaping () -> Void) {
        networkService.getAllCoins { result in
            switch result {
            case .Success(let coins):
                self.coins = coins
                completion()
            case .Error:
                print("Failed")
            }
        }
    }
    
    func getCoin(at index: Int) -> Coin? {
        if coins.count > 0 {
            return coins[index]
        } else {
            return nil
        }
    }
    
    func getCoinsCount() -> Int {
        return coins.count
    }
    
    // MARK: - Configure Cell
    func configureCell(cell: CoinCell, at index: Int) {
        let coin = coins[index]
        let coinCellViewModel = CoinCellViewModel(model: coin, networkService: networkService)
        cell.configure(using: coinCellViewModel)
    }
}
