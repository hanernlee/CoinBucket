//
//  SuggestionCell.swift
//  CoinBucket
//
//  Created by Christopher Lee on 6/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class SuggestionCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - Properties
    public var didTapSuggestionCell: (() -> Void)?

    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = ""
    }
    
    public func configure(using viewModel: SuggestionCellViewModel) {
        nameLabel.text = viewModel.name
        nameLabel.textColor = .darkGray
    }
}

