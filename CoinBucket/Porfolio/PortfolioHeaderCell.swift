//
//  PortfolioHeaderCell.swift
//  CoinBucket
//
//  Created by Christopher Lee on 6/3/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class PortfolioHeaderCell: UICollectionViewCell {
    var savedCoins = [Coin]() {
        didSet {
            getTotalCoin()
            configureUI()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func getTotalCoin() {
        for coin in savedCoins {
            let quantity = NSDecimalNumber(string: coin.quantity)
            let decPrice = NSDecimalNumber(string: coin.price)
            let price = NSDecimalNumber(string: decPrice.toDecimals())
            let totalPrice = ((quantity as Decimal) * (price as Decimal)) as NSDecimalNumber
            
            print(totalPrice)

        }
    }
    
    fileprivate func configureUI() {
    }
}

