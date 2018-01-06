//
//  CoinViewController+UISearchBarDelegate.swift
//  CoinBucket
//
//  Created by Christopher Lee on 16/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

extension CoinsViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchCoin(id:)), object: lastSearched)
        
        lastSearched = searchText as NSString
        self.perform(#selector(searchCoin(id:)), with: lastSearched, afterDelay: 1.0)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        
        progressHUD.hide()
        
        filterCoins(searchBar: searchController.searchBar, searchText: searchText) { (coins) in
            if (coins.isEmpty) {
                
                let view = UIView()
                view.backgroundColor = .yellow
                
                let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height

                let label = UILabel()
                label.numberOfLines = 0
                label.text = "Search for '\(searchText)'"
                label.backgroundColor = .red
                label.sizeToFit()
                view.addSubview(label)
                label.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: navigationBarHeight, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
                self.collectionView?.backgroundView = view
//                NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchCoin(id:)), object: lastSearched)
//                lastSearched = searchText as NSString
//                self.perform(#selector(searchCoin(id:)), with: lastSearched, afterDelay: 1.0)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        progressHUD.hide()
    }
}
