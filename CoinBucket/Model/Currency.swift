//
//  Currency.swift
//  CoinBucket
//
//  Created by Christopher Lee on 19/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation

class Currency {
    let name: String
    var checked = false
    
    
    init(name: String) {
        self.name = name
    }
    
    func toggleChecked() {
        checked = !checked
    }
}
