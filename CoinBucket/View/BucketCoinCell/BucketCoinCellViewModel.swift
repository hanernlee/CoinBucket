//
//  BucketCoinCellViewModel.swift
//  CoinBucket
//
//  Created by Christopher Lee on 21/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

class BucketCoinCellViewModel {
    let id: String
    let name: String
    let fullName: String
    let imageUrl: String
    let price: String
    let priceBTC: String
    let changePercent24Hour: String
    let quantity: Float
    
    let networkService: NetworkService
    let environmentService: EnvironmentServiceProtocol
    
    public var totalPriceFloat: Float {
        let filteredPrice = price.filter { "0123456789.".contains($0) }
        let filteredPriceFloat = Float(filteredPrice) ?? 0
        let total = filteredPriceFloat * quantity
        return total
    }
    
    public var totalPrice: String {
        let filteredPrice = price.filter { "0123456789.".contains($0) }
        let filteredPriceFloat = Float(filteredPrice) ?? 0
        let total = filteredPriceFloat * quantity
        let formattedTotal =  String(format: "%.2f", arguments: [total])
        return "\(environmentService.currency) $ \(formattedTotal)"
    }
    
    init(coinModel: Coin, priceModel: [String: CoinPriceDisplay], networkService: NetworkService, environmentService: EnvironmentServiceProtocol) {
        self.id = coinModel.id
        self.name = coinModel.name
        self.fullName = coinModel.fullName
        self.imageUrl = coinModel.imageUrl
        
        self.price = priceModel[environmentService.currency]?.price ?? ""
        self.priceBTC = priceModel["BTC"]?.price ?? ""
        self.changePercent24Hour = priceModel[environmentService.currency]?.changePercent24Hour ?? ""
        
        self.quantity = environmentService.bucket[coinModel.name] ?? 0.0
        
        self.networkService = networkService
        self.environmentService = environmentService
    }
}
