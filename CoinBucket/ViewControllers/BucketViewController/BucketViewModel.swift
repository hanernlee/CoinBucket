//
//  BucketViewModel.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

public class BucketViewModel {
    private let environmentService: EnvironmentServiceProtocol
    private let networkService: NetworkService
    
    private var coins = [ConstructedCoin]()
    private var symbols = [[String]]()
    private var currentBucket: [String: Float] = [:]
    private var overallTotal: Float = 0.0
    
    public var isLoadingNextPage: Bool = false
    public var hasLoadedAllCoins: Bool = false
    public var isRefreshing: Bool = false

    public var refreshControlText: NSAttributedString = NSAttributedString(string: "")
    
    private var initialCurrency: String
    
    init(environmentService: EnvironmentServiceProtocol, networkService: NetworkService) {
        self.environmentService = environmentService
        self.networkService = networkService
        self.initialCurrency = environmentService.currency
    }
    
    func getCoinsFromDataStorage(completion: @escaping () -> Void) {
        if isRefreshing {
            reset()
        }
        currentBucket = environmentService.bucket
        
        var currencySymbols = [String]()
        
        if environmentService.bucket.isEmpty {
            completion()
        }
        
        environmentService.bucket.forEach { (key, value) in
            if value != 0.0 {
                currencySymbols.append(key)
            }
        }
        
        let symbols = currencySymbols.chunked(into: 50)
    
        symbols.forEach { (symbolArray) in
            networkService.getCoin(symbols: symbolArray, currency: environmentService.currency) { (result) in
                switch result {
                case .Success(let constructedCoins):
                    self.coins.append(contentsOf: constructedCoins)
                    self.coins = self.coins.sorted(by: { $1.coin.fullName > $0.coin.fullName })
                    completion()
                case .Error:
                    print("Failed")
                }
            }
        }
        
        self.isRefreshing = false
        self.configureRefreshControlText()
    }
    
    func getCoinsCount() -> Int {
        return coins.count
    }
    
    func shouldBucketChange() -> Bool {
        return currentBucket != environmentService.bucket
    }

    func bucketIsEmpty() -> Bool {
        return environmentService.bucket.isEmpty
    }
    
    // MARK: - Currency View Controller
    
    func createCurrencyViewController() -> CurrencyViewController {
        let viewModel = CurrencyViewModel(environmentService: environmentService)
        return CurrencyViewController.instantiate(viewModel: viewModel)
    }
    
    func getSelectedCurrency() -> String {
        return environmentService.currency
    }
    
    func configureCoinCell(cell: BucketCoinCell, at index: Int) {
        guard coins.indices.contains(index) else { return }
        
        let coin = coins[index].coin
        let price =  coins[index].price
        
        let bucketCoinCellViewModel = BucketCoinCellViewModel(coinModel: coin, priceModel: price, networkService: networkService, environmentService: environmentService)

        overallTotal += bucketCoinCellViewModel.totalPriceFloat

        cell.configure(using: bucketCoinCellViewModel)
    }
    
    // MARK: - Bucket Coin Header
    func createBucketCoinHeaderViewModel() -> BucketCoinHeaderViewModel {
        return BucketCoinHeaderViewModel(count: overallTotal, environmentService: environmentService)
    }
    
    // MARK: - Create Details View Controller
    func createCoinDetailsViewController(for index: Int) -> CoinDetailsViewController {
        let coin = coins[index].coin
        let price =  coins[index].price
        
        let viewModel = CoinDetailsViewModel(coinModel: coin, priceModel: price, environmentService: environmentService)
        let addToBucketLauncher = AddToBucketLauncher(coin: coin, environmentService: environmentService)
        return CoinDetailsViewController.instantiate(viewModel: viewModel, addToBucketLauncher: addToBucketLauncher)
    }
    
    func shouldRefreshCurrency(completion: @escaping (Bool) -> Void) {
        let shouldRefresh = (initialCurrency != environmentService.currency)
        
        if shouldRefresh {
            initialCurrency = environmentService.currency
            reset()
        }
        
        completion(shouldRefresh)
    }
    
    func configureRefreshControlText() {
        let displayString = Date().toString(dateFormat: "d MMM yyyy h:mm a")
        refreshControlText = NSAttributedString(string: "Last updated \(displayString)")
    }
    
    func reset() {
        coins = [ConstructedCoin]()
        symbols = [[String]]()
        currentBucket = [:]
        overallTotal = 0
        
        isLoadingNextPage = false
        hasLoadedAllCoins = false
        isRefreshing = false
    }
}
