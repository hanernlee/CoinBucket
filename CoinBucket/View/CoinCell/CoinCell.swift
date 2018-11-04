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

    // MARK: - IBOutlet
    
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinFullName: UILabel!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinPriceLabel: UILabel!
    @IBOutlet weak var percentChangeLabel: UILabel!
    
    // MARK: - Properties
    
    public override func awakeFromNib() {
        self.contentView.layer.cornerRadius = 12.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 12.0
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }

    public override func prepareForReuse() {
        coinPriceLabel.text = ""
        coinImage.image = nil
    }
    
    // MARK: - Configure
    
    public func configure(using viewModel: CoinCellViewModel) {
        coinFullName.text = viewModel.fullName
        coinName.text = "(\(viewModel.name))"
        coinPriceLabel.text = "\(viewModel.price)"
        percentChangeLabel.text = "\(viewModel.changePercent24Hour)%"
        percentChangeLabel.textColor = viewModel.percentColor()
        
        configureImage(viewModel.imageUrl)
    }
    
    private func configureImage(_ imageUrl: String) {
        guard let url = URL(string: "\(APIClient.baseUrl)\(imageUrl)"), let placeholderImage = UIImage(named: "coin_deposit") else {
                return
        }
        coinImage.af_setImage(withURL: url, placeholderImage: placeholderImage)
    }
}
