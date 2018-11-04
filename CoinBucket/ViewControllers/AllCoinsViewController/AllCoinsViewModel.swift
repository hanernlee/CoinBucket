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

    private var coins = [ConstructedCoin]()
    private var coinPrices : [Int: String] = [:]
    private var page: Int = 0
    public var isLoadingNextPage: Bool = false
    public var hasLoadedAllCoins: Bool = false
    
    init (environmentService: EnvironmentServiceProtocol, networkService: NetworkService) {
        self.environmentService = environmentService
        self.networkService = networkService
    }
    
    func getCoins(completion: @escaping() -> Void) {
        guard isLoadingNextPage == false,
            hasLoadedAllCoins == false
            else { return }

        isLoadingNextPage = true

        networkService.getCoins(page: page) { [weak self] result in
            guard let `self` = self else { return }

            switch result {
            case .Success(let constructedCoins):
                guard constructedCoins.count > 0 else {
                    self.isLoadingNextPage = false
                    self.hasLoadedAllCoins = true
                    return completion()
                }
                
                constructedCoins.forEach{ self.coins.append($0) }
                self.page += 1
                self.isLoadingNextPage = false
                completion()
            case .Error:
                print("Failed")
            }
        }
    }
    
    func getCoinsCount() -> Int {
        return coins.count
    }

    // MARK: - Configure Cell

    func configureCell(cell: CoinCell, at index: Int) {
        guard coins.indices.contains(index) else { return }
        
        let coin = coins[index].coin
        let price =  coins[index].price
        
        let coinCellViewModel = CoinCellViewModel(coinModel: coin, priceModel: price, networkService: networkService)
        cell.configure(using: coinCellViewModel)
    }
}
