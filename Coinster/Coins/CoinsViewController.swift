//
//  CollectionViewController.swift
//  Coinster
//
//  Created by Christopher Lee on 9/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class CoinsViewController: UICollectionViewController {
    
    let coinCellId = "coinCellId"
    let service = CoinService()
    
    var coins = [Coin]() {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        navigationItem.title = "Coins"
        
        registerView()
        fetchCoins()
    }
    
    // MARK: - Fileprivate Methods
    fileprivate func registerView() {
        collectionView?.register(CoinCell.self, forCellWithReuseIdentifier: coinCellId)
    }
    
    func fetchCoins() {
        service.get { [weak self] (result) in
            switch result {
            case .Success(let coins):
                var tempCoins = [Coin]()
                for coin in coins {
                    if let coin = coin {
                        tempCoins.append(coin)
                    }
                }
                self?.coins = tempCoins
            case .Error(let error):
                // @TODO Show Network Error / Placeholder
                print(error)
            }
        }
    }

}
