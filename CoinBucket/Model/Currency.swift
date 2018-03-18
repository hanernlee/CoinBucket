//
//  Currency.swift
//  CoinBucket
//
//  Created by Christopher Lee on 19/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation

class Currency: Codable {
    let name: String
    let locale: String
    var checked = false
    
    
    init(name: String, locale: String) {
        self.name = name
        self.locale = locale
    }
    
    func toggleChecked() {
        checked = !checked
    }
}
