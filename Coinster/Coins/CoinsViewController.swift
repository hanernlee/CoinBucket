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
    let dateFormatter = DateFormatter()
    let searchController = UISearchController(searchResultsController: nil)
    
    var coins = [Coin]() {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    var filteredCoins = [Coin]()
    
    var lastSearched: NSString? = nil
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        registerView()
        getCoins(fromService: service)
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
    
    @objc func searchCoin(id: String) {
        print("Searching Coin")
        print("\(id)")
//        getCoin(fromService: service, id: id)
    }
    
    // MARK: - Fileprivate Methods
    fileprivate func configureUI() {
        collectionView?.backgroundColor = .white
        navigationItem.title = "Coins"
        
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"

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
    
    fileprivate func getCoins<S: Gettable>(fromService service: S) where S.T == Array<Coin?> {
        service.get (id: nil) { [weak self] (result) in
            self?.collectionView?.refreshControl?.endRefreshing()

            switch result {
            case .Success(let coins):
                var tempCoins = [Coin]()
                for coin in coins {
                    if let coin = coin {
                        tempCoins.append(coin)
                    }
                }

                let now = Date()
                let updateString = now.toString(dateFormat: "d MMM yyyy h:mm a")
                self?.collectionView?.refreshControl?.attributedTitle = NSAttributedString(string: "Last updated \(updateString)")
                self?.coins = tempCoins
                self?.filteredCoins = tempCoins
            case .Error(let error):
                // @TODO Show Network Error / Placeholder
                print(error)
            }
        }
    }
    
    fileprivate func getCoin<S: Gettable>(fromService service: S, id: String) where S.T == Array<Coin?> {
        service.get (id: id) { [weak self] (result) in
            self?.collectionView?.refreshControl?.endRefreshing()
            
            switch result {
            case .Success(let coins):
                var tempCoins = [Coin]()
                for coin in coins {
                    if let coin = coin {
                        tempCoins.append(coin)
                    }
                }
                
                let now = Date()
                let updateString = now.toString(dateFormat: "d MMM yyyy h:mm a")
                self?.collectionView?.refreshControl?.attributedTitle = NSAttributedString(string: "Last updated \(updateString)")
                self?.coins = tempCoins
                self?.filteredCoins = tempCoins
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
