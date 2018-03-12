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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCoin = filteredCoins[indexPath.item]
        let symbol = selectedCoin.symbol
        let coinsDict: [String: Coin] = ["\(symbol)": selectedCoin]
        let userDefaults = UserDefaults.standard
        
        let coinDataView = CoinDataViewController()
        navigationController?.pushViewController(coinDataView, animated: true)
        
//        if let data = userDefaults.value(forKey: "savedCoins") as? Data {
//            var currentCoinsDict = try? PropertyListDecoder().decode([String: Coin].self, from: data)
//            currentCoinsDict![symbol] = selectedCoin
//
//            userDefaults.set(try? PropertyListEncoder().encode(currentCoinsDict), forKey: "savedCoins")
//        } else {
//            userDefaults.set(try? PropertyListEncoder().encode(coinsDict), forKey: "savedCoins")
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 24, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
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
