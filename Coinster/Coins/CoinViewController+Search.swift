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
        print(coins)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        
        progressHUD.hide()
        
        filterCoins(searchBar: searchController.searchBar, searchText: searchText) { (coins) in
            if (coins.isEmpty) {
                NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchCoin(id:)), object: lastSearched)
                
                lastSearched = searchText as NSString
                self.perform(#selector(searchCoin(id:)), with: lastSearched, afterDelay: 1.0)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        progressHUD.hide()
    }
}
