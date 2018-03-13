//
//  CoinDataViewController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 11/3/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class CoinDataViewController: UICollectionViewController {
    
    var model: CoinViewModel?
    var coin: Coin?
    var stateController: StateController?

    let headerCell = "HeaderCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerView()
        configureUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Fileprivate Methods
    fileprivate func registerView() {
        collectionView?.register(CoinDataHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerCell)
    }

    fileprivate func configureUI() {
        collectionView?.backgroundColor = .groupTableViewBackground
        navigationItem.title = "Coin Data"
    }
}
