//
//  CollectionViewController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 9/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class CoinsViewController: UICollectionViewController {
    
    let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var emptyTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16);
        textView.textColor = .gray
        return textView
    }()
    
    lazy var currencyRightButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
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
        
        definesPresentationContext = true
        
        configureUI()
        registerView()
        
        selectedCurrency = stateController.currency
        
        fetchCoins(start: start)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        progressHUD.activityIndictor.isHidden = true
        
        guard let currentCurrency = selectedCurrency else { return }

        if currentCurrency.name != stateController.currency.name {
            selectedCurrency = stateController.currency
            handleRefresh()
        } else {
            print("Same")
        }

        guard let navigationBar = navigationController?.navigationBar else { return }
        
        navigationBar.addSubview(currencyRightButton)
        currencyRightButton.setTitle("\(stateController.currency.name)", for: .normal)
        currencyRightButton.anchor(top: nil, left: nil, bottom: navigationBar.bottomAnchor, right: navigationBar.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 16, width: 0, height: 0)
    }
    
    // MARK: - Fileprivate Methods
    fileprivate func configureUI() {
        collectionView?.backgroundColor = .white
        collectionView?.backgroundView = emptyView

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Coins"
                
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
        emptyTextView.removeFromSuperview()
        progressHUD.show()
        progressHUD.text = "Updating..."
    }
    
    @objc func searchCoin(id: String) {
        let service = CoinService(id: id, start: 0, convert: stateController.currency.name)
        emptyTextView.removeFromSuperview()

        progressHUD.show()
        progressHUD.text = "Searching \(id)"
        getCoin(fromService: service)
    }
    
    @objc func goToSettings() {
        tabBarController?.selectedIndex = 1
    }
}
