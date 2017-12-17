//
//  CoinsViewController+Service.swift
//  Coinster
//
//  Created by Christopher Lee on 17/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

extension CoinsViewController {
    // MARK: - Get Request Coins
    func getCoins<S: Gettable>(fromService service: S) where S.T == Array<Coin?> {
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
                
                let now = Date()
                let updateString = now.toString(dateFormat: "d MMM yyyy h:mm a")
                self?.collectionView?.refreshControl?.attributedTitle = NSAttributedString(string: "Last updated \(updateString)")
                self?.coins = tempCoins
                self?.filteredCoins = tempCoins
                self?.progressHUD.hide()
            case .Error(let error):
                // @TODO Show Network Error / Placeholder
                print(error)
            }
        }
    }
    
    // MARK: - Get Request More Coins
    func getMoreCoins<S: Gettable>(fromService service: S) where S.T == Array<Coin?> {
        service.get { [weak self] (result) in
            self?.collectionView?.refreshControl?.endRefreshing()
            
            switch result {
            case .Success(let coins):
                for coin in coins {
                    if let coin = coin {
                        self?.coins.append(coin)
                        self?.filteredCoins.append(coin)
                    }
                }
                if coins.count < 200 {
                    self?.isFinishedPaging = true
                }
            case .Error(let error):
                // @TODO Show Network Error / Placeholder
                print(error)
            }
        }
    }
    
    // MARK: - Get Request Specific Coin
    func getCoin<S: Gettable>(fromService service: S) where S.T == Array<Coin?> {
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
                
                self?.filteredCoins = tempCoins
                self?.collectionView?.reloadData()
                self?.progressHUD.hide()
            case .Error(let error):
                // @TODO Show Network Error / Placeholder
                self?.progressHUD.showWithoutSpinner()
                self?.progressHUD.text = "Oops! Sorry can't find that Coin"
                print(error)
            }
        }
    }
}
