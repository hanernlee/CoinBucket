//
//  CoinViewController+UISearchBarDelegate.swift
//  CoinBucket
//
//  Created by Christopher Lee on 16/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

extension CoinsViewController: UISearchBarDelegate, UISearchResultsUpdating {
    // Handle Search button clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
                
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchCoin(id:)), object: lastSearched)
        
        lastSearched = searchText as NSString
        self.perform(#selector(searchCoin(id:)), with: lastSearched, afterDelay: 1.0)
    }
    
    // Update Search results
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        
        loadingHUD.hide()
        
        filterCoins(searchBar: searchController.searchBar, searchText: searchText) { (coins) in
            if (coins.isEmpty) {
                let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height

                emptyView.addSubview(emptyTextView)
                emptyTextView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: navigationBarHeight, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
                emptyTextView.text = "Search for '\(searchText)'"
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadingHUD.hide()
        searchController.isActive = true
        emptyTextView.removeFromSuperview()
    }
}
