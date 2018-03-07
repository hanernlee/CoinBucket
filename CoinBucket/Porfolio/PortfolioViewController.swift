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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupCoins()
        collectionView?.reloadData()
    }
    
    // MARK: - Fileprivate Methods
    fileprivate func configureUI() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
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
    
    fileprivate func registerView() {
        collectionView?.register(PortfolioHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCell)
        collectionView?.register(CoinCell.self, forCellWithReuseIdentifier: coinCell)
    }
    
    // MARK: - #Selector Events
    @objc func handleRefresh() {
        for coin in savedCoins {
            let service = CoinService(id: coin.id, start: 0, convert: stateController.currency.name)
            
            progressHUD.show()
            progressHUD.text = "Updating prices"
            getCoin(fromService: service)
        }
    }
}
