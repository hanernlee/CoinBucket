//
//  CoinsViewController+Actions.swift
//  Coinster
//
//  Created by Christopher Lee on 24/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

extension CoinsViewController {
    // MARK:- Fetch Coins
    func fetchCoins(start: Int) {
        let service = CoinService(id: nil, start: start)
        progressHUD.text = "Fetching Coins"
        getCoins(fromService: service)
    }
    
    func fetchMoreCoins() {
        start += 500
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
}
