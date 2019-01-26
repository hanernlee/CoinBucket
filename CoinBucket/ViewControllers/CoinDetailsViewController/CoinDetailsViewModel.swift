//
//  CoinDetailsViewModel.swift
//  CoinBucket
//
//  Created by Christopher Lee on 12/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class CoinDetailsViewModel {
    let id: String
    let name: String
    let fullName: String
    let imageUrl: String
    let environmentService: EnvironmentServiceProtocol
    let price: String
    let priceBTC: String
    let changePercent24Hour: String
    let changePercent24HourBTC: String
    let marketCap: String
    let marketCapBTC: String
    let supply: String
    let volume24H: String
    let volume24HTO: String
    let totalVolume24H: String
    let totalVolume24HTO: String
    let priceOpen24Hour: String
    let priceHigh24Hour: String
    let priceLow24Hour: String
    
    
    init(coinModel: Coin, priceModel: [String: CoinPriceDisplay], environmentService: EnvironmentServiceProtocol) {
        self.id = coinModel.id
        self.name = coinModel.name
        self.fullName = coinModel.fullName
        self.imageUrl = coinModel.imageUrl
        
        self.price = priceModel[environmentService.currency]?.price ?? ""
        self.changePercent24Hour = priceModel[environmentService.currency]?.changePercent24Hour ?? ""
        
        self.priceBTC = priceModel["BTC"]?.price ?? ""
        self.changePercent24HourBTC = priceModel["BTC"]?.changePercent24Hour ?? ""
        
        self.marketCap = priceModel[environmentService.currency]?.marketCap ?? ""
        self.marketCapBTC = priceModel["BTC"]?.marketCap ?? ""
        
        self.supply = priceModel[environmentService.currency]?.supply ?? ""
        
        self.volume24H = priceModel[environmentService.currency]?.volume24H ?? ""
        self.volume24HTO = priceModel[environmentService.currency]?.volume24HTO ?? ""

        self.totalVolume24H = priceModel[environmentService.currency]?.totalVolume24H ?? ""
        self.totalVolume24HTO = priceModel[environmentService.currency]?.totalVolume24HTO ?? ""
        
        self.priceOpen24Hour = priceModel[environmentService.currency]?.priceOpen24Hour ?? ""
        self.priceLow24Hour = priceModel[environmentService.currency]?.priceLow24Hour ?? ""
        self.priceHigh24Hour = priceModel[environmentService.currency]?.priceHigh24Hour ?? ""
        
        self.environmentService = environmentService
    }
    
    func percentageChangeColor() -> UIColor {
        guard let percentChange = Float(changePercent24Hour) else { return .red }
        return percentChange >= 0 ? .green : .red
    }
    
    func percentageChangeBTCColor() -> UIColor {
        guard let percentChange = Float(changePercent24HourBTC) else { return .red }
        return percentChange >= 0 ? .green : .red
    }
    
    func presentInBucket() -> Bool {
        return environmentService.bucket[name] != nil
    }
}
