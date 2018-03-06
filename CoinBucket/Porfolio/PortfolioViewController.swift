//
//  PortfolioViewController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 9/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class PortfolioViewController: UICollectionViewController {
    
    var stateController: StateController!
    
    let headerCell = "HeaderCell"

    let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .groupTableViewBackground
        
        navigationItem.title = "Portfolio"
        
        configureUI()
        registerView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupCoins()
    }
    
    fileprivate func configureUI() {
        
    }
    
    fileprivate func setupCoins() {
        if let data = UserDefaults.standard.value(forKey: "savedCoins") as? Data {
            let coins = try? PropertyListDecoder().decode(Array<Coin>.self, from: data)
            print(coins)
        }
    }
    
    fileprivate func registerView() {
        collectionView?.register(PortfolioHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCell)
    }
}
