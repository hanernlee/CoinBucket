//
//  CoinCell.swift
//  CoinBucket
//
//  Created by Christopher Lee on 30/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit
import AlamofireImage

class CoinCell: UICollectionViewCell {
    
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinFullName: UILabel!
    
    public func configure(using viewModel: CoinCellViewModel) {
        coinFullName?.text = viewModel.fullName
        
        if let url = URL(string: "\(API.baseUrl)\(viewModel.imageUrl)") {
            let placeholderImage = UIImage(named: "coin_deposit")!
            coinImage.af_setImage(withURL: url, placeholderImage: placeholderImage)
        }
    }
}
