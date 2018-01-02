//
//  LoadingCell.swift
//  CoinBucket
//
//  Created by Christopher Lee on 17/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class LoadingCell: UICollectionViewCell {
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        spinner.startAnimating()
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSpinner()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        spinner.startAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureSpinner() {
        addSubview(spinner)
        spinner.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
}
