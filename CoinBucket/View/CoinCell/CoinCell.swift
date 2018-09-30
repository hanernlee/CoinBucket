//
//  CoinCell.swift
//  CoinBucket
//
//  Created by Christopher Lee on 30/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class CoinCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .yellow
    }
}
