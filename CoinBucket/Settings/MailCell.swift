//
//  MailCell.swift
//  CoinBucket
//
//  Created by Christopher Lee on 23/3/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class MailCell: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        selectionStyle = .none

        label.text = "Contact Us"
        addSubview(label)
        label.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 45)
    }
}
