//
//  CoinsViewController+UICollectionView.swift
//  CoinBucket
//
//  Created by Christopher Lee on 10/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

extension CoinsViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filteredCoins.count == 0 {
            collectionView.backgroundView?.isHidden = false
        } else {
            collectionView.backgroundView?.isHidden = true
        }
        
        return filteredCoins.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == coins.count - 1 && !isFinishedPaging {
            let loadingCell = collectionView.dequeueReusableCell(withReuseIdentifier: coinLoadingCell, for: indexPath) as! LoadingCell
            fetchMoreCoins()
            
            return loadingCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: coinCell, for: indexPath) as! CoinCell
        let coin = filteredCoins[indexPath.item]
        let coinViewModel = CoinViewModel(model: coin)
        cell.displayCoinInCell(using: coinViewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let searchText = searchController.searchBar.text ?? ""

        if searchText.isEmpty {
            searchController.isActive = false
        } else {
            searchController.searchBar.endEditing(true)
        }
    }
}
