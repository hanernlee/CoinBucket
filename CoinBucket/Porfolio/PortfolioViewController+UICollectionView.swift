//
//  PortfolioViewController+UICollectionView.swift
//  CoinBucket
//
//  Created by Christopher Lee on 6/3/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

extension PortfolioViewController: UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedCoins.count
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: coinCell, for: indexPath) as! CoinCell
        let coin = savedCoins[indexPath.item]
        var coinViewModel = CoinViewModel(model: coin)
        coinViewModel.coinType = "\(viewType.PortfolioCoin)"
        cell.displayCoinInCell(using: coinViewModel)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCell, for: indexPath) as! PortfolioHeaderCell
            cell.savedCoins = savedCoins
            cell.totalPrice = 0
            return cell
        default:  fatalError("Unexpected element kind")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coin = savedCoins[indexPath.item]
        let coinViewModel = CoinViewModel(model: coin)
        
        let coinDataView = CoinDataViewController(collectionViewLayout: UICollectionViewFlowLayout())
        coinDataView.model = coinViewModel
        coinDataView.coin = coin
        coinDataView.stateController = stateController
        navigationController?.pushViewController(coinDataView, animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 300)
    }
}
