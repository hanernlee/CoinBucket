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
    
    var totalCoins: Int = 0
    
    let bucket: UIView = {
        let view = UIView()
//        view.backgroundColor = .red
        return view
    }()
    
    let bucketHeight: CGFloat = 200
    let bucketWidth: CGFloat = 150

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func getTotalCoin() {
        totalCoins = 0
        for coin in savedCoins {
            guard let quantity = coin.quantity else { return }
            print(quantity)
            totalCoins = totalCoins + Int(quantity)!
        }
        print(totalCoins)
    }
    
    fileprivate func configureUI() {
        addSubview(bucket)
        bucket.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        bucket.frame = CGRect(x: self.frame.width / 2 - bucketWidth / 2, y: self.frame.height / 2 - bucketHeight / 2, width: bucketWidth  , height: bucketHeight)

        for coin in savedCoins {
            let bucketSlice = drawBucketSlice(coin: coin)
            bucket.addSubview(bucketSlice)
        }
    }
    
    fileprivate func drawBucketSlice(coin: Coin) -> UIView {
        if let qCoin = NumberFormatter().number(from: coin.quantity!) {
            let sliceQuantity = CGFloat(truncating: qCoin)
            
            let height: CGFloat = sliceQuantity / CGFloat(totalCoins) * bucketHeight
            let slice = UIView()
            slice.frame = CGRect(x: 0, y: 0, width: bucketWidth, height: height)
            slice.backgroundColor = .random()
            return slice
        }
        
        return UIView()
    }
}

