//
//  CoinCell.swift
//  Coinster
//
//  Created by Christopher Lee on 10/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class CoinCell: UICollectionViewCell {
    
    let coinNameLabel: UILabel = {
        let label = UILabel();
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .green
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        addSubview(coinNameLabel)
        coinNameLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    
    func displayCoinInCell(using viewModel: CoinViewModel) {
        coinNameLabel.text = viewModel.name

//        movieImage.loadImageUsingCacheWithURLString(viewModel.imageURL, placeHolder: nil) { (bool) in
//            //perform actions if needed
//        }
    }
}
