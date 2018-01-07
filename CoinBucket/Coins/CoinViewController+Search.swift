//
//  CoinViewController+UISearchBarDelegate.swift
//  CoinBucket
//
//  Created by Christopher Lee on 16/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

extension CoinsViewController: UISearchBarDelegate, UISearchResultsUpdating, UITextViewDelegate {
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
                let navigationBarHeight: CGFloat = self.navigationController!.navigationBar.frame.height
                collectionView?.backgroundView = emptyView

                emptyView.addSubview(emptyTextView)
                emptyView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
                emptyTextView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: emptyView.frame.width, height: emptyView.frame.height + navigationBarHeight)
                
                emptyTextView.delegate = self
                emptyTextView.text = "Search for '\(searchText)'"
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        progressHUD.hide()
        searchController.isActive = true
        emptyTextView.removeFromSuperview()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        view.layoutIfNeeded()
    }
}
