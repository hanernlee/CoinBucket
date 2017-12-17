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
    let searchController = UISearchController(searchResultsController: nil)
    
    var coins = [Coin]() {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    var filteredCoins = [Coin]()

    var start = 0
    var isFinishedPaging = false
    var lastSearched: NSString? = nil
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        registerView()
        
        fetchCoins(start: start)
    }
    
    // MARK:- Fetch Coins
    func fetchCoins(start: Int) {
        let service = CoinService(id: nil, start: start)
        getCoins(fromService: service)
    }
    
    func fetchMoreCoins() {
        start += 200
        let service = CoinService(id: nil, start: start)
        getMoreCoins(fromService: service)
    }
    
    // MARK: - Filter Coins
    func filterCoins(searchBar: UISearchBar, searchText: String, completion: (([Coin]) -> ())) {
        if searchText.isEmpty {
            filteredCoins = coins
        } else {
            filteredCoins = self.coins.filter { (coin) -> Bool in
                return coin.name.lowercased().contains(searchText.lowercased())
            }
            completion(filteredCoins)
        }
        collectionView?.reloadData()
    }
    
    // MARK: - Fileprivate Methods
    fileprivate func configureUI() {
        collectionView?.backgroundColor = .white
        navigationItem.title = "Coins"

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    fileprivate func registerView() {
        collectionView?.register(CoinCell.self, forCellWithReuseIdentifier: coinCellId)
    }
    
    // MARK: - #Selector Events
    @objc func handleRefresh() {
        coins.removeAll()
        start = 0
        isFinishedPaging = false
        searchController.isActive = false
        fetchCoins(start: start)
    }
    
    @objc func searchCoin(id: String) {
        let service = CoinService(id: id, start: 0)
        getCoin(fromService: service)
    }
}
