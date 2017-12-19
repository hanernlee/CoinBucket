//
//  CurrencyViewModel.swift
//  Coinster
//
//  Created by Christopher Lee on 19/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation

struct CurrencyViewModel {
    let currency: String
    var checked: Bool
    
    init(model: Currency) {
        self.currency = model.currency
        self.checked = model.checked
    }
}
