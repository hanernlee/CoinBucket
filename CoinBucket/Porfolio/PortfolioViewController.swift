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
    
    lazy var currencyRightButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        button.setTitleColor(.gray, for: .normal)
        return button
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
        
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.addSubview(currencyRightButton)
        currencyRightButton.anchor(top: nil, left: nil, bottom: navigationBar.bottomAnchor, right: navigationBar.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 5, paddingRight: 16, width: 0, height: 0)
        
        view.addSubview(progressHUD)
    }
    
    fileprivate func registerView() {
        collectionView?.register(PortfolioHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCell)
        collectionView?.register(CoinCell.self, forCellWithReuseIdentifier: coinCell)
    }
    
    fileprivate func changeCurrency() {
        currencyRightButton.setTitle("\(stateController.currency.name)", for: .normal)
        guard let currentCurrency = selectedCurrency else { return }

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
    
    @objc func goToSettings() {
        tabBarController?.selectedIndex = 2
    }
}
