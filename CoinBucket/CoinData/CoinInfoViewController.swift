//
//  CoinDataViewController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 11/3/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class CoinDataViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Fileprivate Methods
    fileprivate func configureUI() {
        view.backgroundColor = .groupTableViewBackground

        navigationItem.title = "Coins"
    }
    
}
