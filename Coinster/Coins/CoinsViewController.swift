//
//  CollectionViewController.swift
//  Coinster
//
//  Created by Christopher Lee on 9/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class CoinsViewController: UICollectionViewController {
    
    fileprivate var request: AnyObject?
    let coinCellId = "coinCellId"
    var coins = [Coin]()
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .blue

        navigationItem.title = "Title"
        
        registerView()
        fetchCoins()
    }
    
    // MARK: - Fileprivate Methods
    fileprivate func registerView() {
        collectionView?.register(CoinCell.self, forCellWithReuseIdentifier: coinCellId)
    }
    
    func fetchCoins() {
        let coinsRequest = CoinService()
        coinsRequest.load { (result) in
            switch result {
            case .Success(let value):
                print(value)
            case .Failure(let error):
                print(error)
            }
        }
        
    }

}
