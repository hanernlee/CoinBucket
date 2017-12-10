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
    
    fileprivate func fetchCoins() {
        let coinsResource = CoinsResource()
        let coinsRequest = APIRequest(resource: coinsResource)
        request = coinsRequest
        coinsRequest.load { [weak self] (fetchedCoins: [Coin]?) in
            guard let fetchedCoins = fetchedCoins else { return }
            
            DispatchQueue.main.async {
                self?.coins = fetchedCoins
                self?.collectionView?.reloadData()
            }
        }
    }
}
