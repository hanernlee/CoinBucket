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
        
        viewModel.getCoinPriceData {
            print("Hey")
        }
        
        configureImage(viewModel.imageUrl)
    }
    
    private func configureImage(_ imageUrl: String) {
        guard let url = URL(string: "\(API.baseUrl)\(imageUrl)"), let placeholderImage = UIImage(named: "coin_deposit") else {
                return
        }
        coinImage.af_setImage(withURL: url, placeholderImage: placeholderImage)
    }
}
