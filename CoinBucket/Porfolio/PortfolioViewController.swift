//
//  PortfolioViewController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 9/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class PortfolioViewController: UICollectionViewController {
    let emptyView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var addCoinBtn: UIButton = {
        let button = UIButton()
        button.setTitle("+ Add Coins", for: .normal)
        button.backgroundColor = .orange
        button.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(goToCoins), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var currencyRightButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    var stateController: StateController!
    var selectedCurrency: Currency?
    var savedCoins = [Coin]()
    let loadingHUD = LoadingHUD()

    let headerCell = "HeaderCell"
    let headerEmptyCell = "HeaderEmptyCell"
    let coinCell = "CoinCell"

    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .groupTableViewBackground
        navigationItem.title = "Bucket"
        
        configureUI()
        registerView()
        
        selectedCurrency = stateController.currency
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        loadingHUD.hide()
        setupCoins()
        changeCurrency()
        toggleAddCoinBtn()

        collectionView?.reloadData()
    }
    
    // MARK: - Fileprivate Methods
    fileprivate func configureUI() {
        collectionView?.backgroundView = emptyView
        view.addSubview(addCoinBtn)
        addCoinBtn.center = view.center
        toggleAddCoinBtn()
        
        // Setup refreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        // Setup currency button that goes to Settings
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.addSubview(currencyRightButton)
        currencyRightButton.anchor(top: nil, left: nil, bottom: navigationBar.bottomAnchor, right: navigationBar.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 16, width: 0, height: 0)
        
        view.addSubview(loadingHUD)
        loadingHUD.hide()
    }
    
    // Toggle Add Coin button
    fileprivate func toggleAddCoinBtn() {
        if savedCoins.count == 0 {
            addCoinBtn.isHidden = false
        } else {
            addCoinBtn.isHidden = true
        }
    }
    
    // Registers reusable cells
    fileprivate func registerView() {
        collectionView?.register(PortfolioHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCell)
        collectionView?.register(PortfolioHeaderEmptyCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerEmptyCell)
        collectionView?.register(CoinCell.self, forCellWithReuseIdentifier: coinCell)
    }
    
    // Handle currency change
    fileprivate func changeCurrency() {
        currencyRightButton.setTitle("\(stateController.currency.name)", for: .normal)
        guard let currentCurrency = selectedCurrency else { return }

        if currentCurrency.name != stateController.currency.name {
            selectedCurrency = stateController.currency
            loadingHUD.show()
            handleRefresh()
        } else if !savedCoins.isEmpty {
            for coin in savedCoins {
                if (coin.currency != stateController.currency.name) {
                    return handleRefresh()
                }
            }
        }
    }
    
    // Setup coins if saved in UserDefaults
    func setupCoins() {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.value(forKey: "savedCoins") as? Data {
            let coins = try? PropertyListDecoder().decode([String: Coin].self, from: data)
            
            savedCoins.removeAll()

            for (_, value) in coins! {
                savedCoins.append(value)
            }
            
            savedCoins = savedCoins.sorted(by: { $0.name < $1.name })
        }
    }
    
    // MARK: - #Selector Events
    // Handle refresh of saved coins
    @objc func handleRefresh() {
        loadingHUD.show()
        
        if savedCoins.count == 0 {
            loadingHUD.hide()
            collectionView?.refreshControl?.endRefreshing()
        }
        
        for coin in savedCoins {
            let service = CoinService(id: coin.id, start: 0, convert: stateController.currency.name)
                
            getCoin(fromService: service)
        }
    }
    
    // Handles tap that goes to Settings
    @objc func goToSettings() {
        tabBarController?.selectedIndex = 2
    }
    
    // Handles tap that goes to Coins
    @objc func goToCoins() {
        tabBarController?.selectedIndex = 1
    }
}
