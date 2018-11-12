//
//  CurrencyCell.swift
//  CoinBucket
//
//  Created by Christopher Lee on 4/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var currencyImageView: UIImageView!
    @IBOutlet weak var checkmarkLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var containerViewTopConstraint: NSLayoutConstraint!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        configureShape()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()

        nameLabel.text = ""
        configureShape()
    }
    
    public func configure(using viewModel: CurrencyCellViewModel) {
        nameLabel.text = viewModel.name
        checkmarkLabel.isHidden = viewModel.isSelectedCurrency() == false
    }
    
    public func configureShape() {
        containerView.layer.cornerRadius = 12.0
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.clear.cgColor
        containerView.layer.masksToBounds = true

        checkmarkLabel.layer.cornerRadius = checkmarkLabel.frame.width / 2
        checkmarkLabel.clipsToBounds = true
    }
}
