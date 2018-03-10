//
//  PortfolioViewController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 9/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class PortfolioViewController: UICollectionViewController {
    
    var stateController: StateController!
    var selectedCurrency: Currency?
    var savedCoins = [Coin]()

    let progressHUD = ProgressHUD(text: "")
    let headerCell = "HeaderCell"
    let coinCell = "CoinCell"

    let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .groupTableViewBackground
        navigationItem.title = "Portfolio"
        
        configureUI()
        registerView()
        
        progressHUD.hide()
        selectedCurrency = stateController.currency
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupCoins()
        changeCurrency()
        collectionView?.reloadData()
    }
    
    // MARK: - Fileprivate Methods
    fileprivate func configureUI() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        view.addSubview(progressHUD)
    }
    
    fileprivate func registerView() {
        collectionView?.register(PortfolioHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCell)
        collectionView?.register(CoinCell.self, forCellWithReuseIdentifier: coinCell)
    }
    
    fileprivate func changeCurrency() {
        guard let currentCurrency = selectedCurrency else { return }
        print(savedCoins)

        if currentCurrency.name != stateController.currency.name {
            selectedCurrency = stateController.currency
            handleRefresh()
        } else if !savedCoins.isEmpty {
            for coin in savedCoins {
                if (coin.currency != stateController.currency.name) {
                    return handleRefresh()
                }
            }
        } else {
            print("Same")
        }
    }
    
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
    @objc func handleRefresh() {
        progressHUD.show()
        progressHUD.text = "Updating"
        
        for coin in savedCoins {
            let service = CoinService(id: coin.id, start: 0, convert: stateController.currency.name)
                
            getCoin(fromService: service)
        }
    }
}
