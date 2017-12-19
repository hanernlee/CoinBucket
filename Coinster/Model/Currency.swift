//
//  Currency.swift
//  Coinster
//
//  Created by Christopher Lee on 19/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation

struct Currency {
    let currency: String
    var checked = false
    
    
    init(currency: String) {
        self.currency = currency
    }
    
    mutating func toggleChecked() {
        checked = !checked
    }
}
