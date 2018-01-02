//
//  CollectionViewController.swift
//  Coinster
//
//  Created by Christopher Lee on 9/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class CoinsViewController: UICollectionViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    let progressHUD = ProgressHUD(text: "")
    let coinCell = "CoinCell"
    let coinLoadingCell = "CoinLoadingCell"
    
    var stateController: StateController!
    var selectedCurrency: Currency?
    
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
        
        selectedCurrency = stateController.currency
        
        fetchCoins(start: start)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let currentCurrency = selectedCurrency else { return }

        if currentCurrency.name != stateController.currency.name {
            selectedCurrency = stateController.currency
            handleRefresh()
        } else {
            print("Same")
        }
    }
    
    // MARK: - Fileprivate Methods
    fileprivate func configureUI() {
        collectionView?.backgroundColor = .white
        navigationItem.title = "Coins (\(stateController.currency.name)"

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.addSubview(progressHUD)
    }
    
    fileprivate func registerView() {
        collectionView?.register(CoinCell.self, forCellWithReuseIdentifier: coinCell)
        collectionView?.register(LoadingCell.self, forCellWithReuseIdentifier: coinLoadingCell)
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
        let service = CoinService(id: id, start: 0, convert: stateController.currency.name)
        progressHUD.show()
        progressHUD.text = "Searching \(id)"
        getCoin(fromService: service)
    }
}
