//
//  SuggestionHeaderView.swift
//  CoinBucket
//
//  Created by Christopher Lee on 17/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class SuggestionHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var suggestionHeaderLabel: UILabel!
    
    override func awakeFromNib() {
        let coloredBackgroundView = UIView()
        coloredBackgroundView.backgroundColor = .bgGray
        self.backgroundView = coloredBackgroundView
    }
}
