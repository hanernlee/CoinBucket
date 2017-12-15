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
        
        setupUI()
        registerView()
        getCoins(fromService: service)
    }
    
    // MARK: - Fileprivate Methods
    fileprivate func setupUI() {
        collectionView?.backgroundColor = .white
        navigationItem.title = "Coins"
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Last updated 5 minutes ago")
        collectionView?.refreshControl = refreshControl
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    fileprivate func registerView() {
        collectionView?.register(CoinCell.self, forCellWithReuseIdentifier: coinCellId)
    }
    
    fileprivate func getCoins<S: Gettable>(fromService service: S) where S.T == Array<Coin?> {
        service.get { [weak self] (result) in
            
            self?.collectionView?.refreshControl?.endRefreshing()

            switch result {
            case .Success(let coins):
                var tempCoins = [Coin]()
                for coin in coins {
                    if let coin = coin {
                        tempCoins.append(coin)
                    }
                }
                print("fetchCoins")
                self?.coins = tempCoins
            case .Error(let error):
                // @TODO Show Network Error / Placeholder
                print(error)
            }
        }
    }
    
    // MARK: - #Selector Events
    @objc func handleRefresh() {
        coins.removeAll()
        getCoins(fromService: service)
    }

}
