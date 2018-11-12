//
//  CurrencyCellViewModel.swift
//  CoinBucket
//
//  Created by Christopher Lee on 4/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation
import UIKit

class CurrencyCellViewModel {
    let name: String
    let systemCurrency: String
    
    init(model: Currency, systemCurrency: String) {
        self.name = model.name
        self.systemCurrency = systemCurrency
    }
    
    public func isSelectedCurrency() -> Bool {
        return name == systemCurrency
    }
}
