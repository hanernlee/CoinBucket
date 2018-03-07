//
//  PortfolioViewController+Service.swift
//  CoinBucket
//
//  Created by Christopher Lee on 7/3/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

extension PortfolioViewController {
    // MARK: - Get Request Specific Coin
    func getCoin<S: Gettable>(fromService service: S) where S.T == Array<Coin?> {
        service.get { [weak self] (result) in
            self?.collectionView?.refreshControl?.endRefreshing()
            
            switch result {
            case .Success(let coins):

                let coin = coins[0]
                
                for savedCoin in self?.savedCoins {
                    
                }

                self?.collectionView?.reloadData()
                self?.progressHUD.hide()
            case .Error(let error):
                if self?.savedCoins.count == 0 {
                    self?.progressHUD.show()
                    self?.progressHUD.text = ":("
                    let alertController = UIAlertController(title: nil, message: "Oops! Sorry we can't seem to find that coin.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self?.present(alertController, animated: true, completion: nil)
                }
                print(error)
            }
        }
    }
}
