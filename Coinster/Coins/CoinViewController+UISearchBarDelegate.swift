//
//  CoinViewController+UISearchBarDelegate.swift
//  Coinster
//
//  Created by Christopher Lee on 16/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

extension CoinsViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Searching")
        print(coins)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        filterCoins(searchBar: searchController.searchBar, searchText: searchText) { (coins) in
            if (coins.isEmpty) {
                NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(CoinsViewController.searchCoin), object: nil)
                self.perform(#selector(CoinsViewController.searchCoin), with: nil, afterDelay: 0.5)
            }
        }
    }
}
