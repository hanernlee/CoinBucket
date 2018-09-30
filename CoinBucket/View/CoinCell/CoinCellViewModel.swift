//
//  CoinCellViewModel.swift
//  CoinBucket
//
//  Created by Christopher Lee on 30/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

class CoinCellViewModel {
    let id: String
    let name: String
    let fullName: String
    let imageUrl: String
    
    init(model: Coin) {
        self.id = model.id
        self.name = model.name
        self.fullName = model.fullName
        self.imageUrl = model.imageUrl
    }
}
