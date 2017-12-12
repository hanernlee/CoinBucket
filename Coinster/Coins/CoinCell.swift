//
//  CoinCell.swift
//  Coinster
//
//  Created by Christopher Lee on 10/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class CoinCell: UICollectionViewCell {
    
    let coinImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .red
        iv.layer.cornerRadius = 40/2
        iv.clipsToBounds = true
        return iv
    }()
    
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
        addSubview(coinImageView)
        coinImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        coinImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        addSubview(coinNameLabel)
        coinNameLabel.anchor(top: topAnchor, left: coinImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    
    func displayCoinInCell(using viewModel: CoinViewModel) {
        coinNameLabel.text = viewModel.name
        coinImageView.image = UIImage(named: viewModel.name)

//        movieImage.loadImageUsingCacheWithURLString(viewModel.imageURL, placeHolder: nil) { (bool) in
//            //perform actions if needed
//        }
    }
}
