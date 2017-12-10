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
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .blue

        navigationItem.title = "Title"
        
        fetchCoins()
    }
    
    // MARK: - Fileprivate Methods
    fileprivate func fetchCoins() {
        let coinsResource = CoinsResource()
        let coinsRequest = APIRequest(resource: coinsResource)
        request = coinsRequest
        coinsRequest.load { [weak self] (coins: [Coin]?) in
            guard let coins = coins else { return }
            

            print(coins)
        }
    }
}
