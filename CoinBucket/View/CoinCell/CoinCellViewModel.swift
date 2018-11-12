//
//  CoinCellViewModel.swift
//  CoinBucket
//
//  Created by Christopher Lee on 30/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation
import UIKit

class CoinCellViewModel {
    let id: String
    let name: String
    let fullName: String
    let imageUrl: String
    let networkService: NetworkService
    let price: String
    let priceBTC: String
    let changePercent24Hour: String
    
    init(coinModel: Coin, priceModel: [String: CoinPriceDisplay], networkService: NetworkService, environmentService: EnvironmentServiceProtocol) {
        self.id = coinModel.id
        self.name = coinModel.name
        self.fullName = coinModel.fullName
        self.imageUrl = coinModel.imageUrl
        
        self.price = priceModel[environmentService.currency]?.price ?? ""
        self.priceBTC = priceModel["BTC"]?.price ?? ""
        self.changePercent24Hour = priceModel[environmentService.currency]?.changePercent24Hour ?? ""

        self.networkService = networkService
    }
    
    func percentColor() -> UIColor {
        guard let percentChange = Float(changePercent24Hour) else { return .red }
        return percentChange >= 0 ? .green : .red
    }
}
