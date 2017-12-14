//
//  CoinHeaderView.swift
//  Coinster
//
//  Created by Christopher Lee on 14/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class CoinHeaderView: UICollectionViewCell {
    let lastUpdatedlabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
//        addSubview(lastUpdatedlabel)
//        lastUpdatedlabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
//        
//        let attributedText = NSMutableAttributedString(string: "Last Updated 3 minutes ago", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
//        lastUpdatedlabel.attributedText = attributedText
        
    }
}
