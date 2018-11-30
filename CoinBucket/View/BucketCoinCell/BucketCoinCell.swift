//
//  BucketCoinCell.swift
//  CoinBucket
//
//  Created by Christopher Lee on 21/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit
import AlamofireImage

class BucketCoinCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinFullName: UILabel!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var coinPriceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    // MARK: - Properties
    public var totalPriceFloat: Float = 0.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureShape()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        coinPriceLabel.text = ""
        coinImage.image = nil
    }
    
    // MARK: - Configure
    
    private func configureShape() {
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
    
    public func configure(using viewModel: BucketCoinCellViewModel) {
        coinFullName.text = viewModel.fullName
        coinName.text = "(\(viewModel.name))"
        coinPriceLabel.text = "\(viewModel.totalPrice)"
        quantityLabel.text = "Qty: \(viewModel.quantity)"
        
        configureImage(viewModel.imageUrl)
    }
    
    private func configureImage(_ imageUrl: String) {
        guard let url = URL(string: "\(APIClient.baseUrl)\(imageUrl)"), let placeholderImage = UIImage(named: "coin_deposit") else {
            return
        }
        coinImage.af_setImage(withURL: url, placeholderImage: placeholderImage)
    }
}
