//
//  AllCoinsViewController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

public class AllCoinsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private properties
    private var viewModel: AllCoinsViewModel!
    
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    // MARK: - Instantiate
    public static func instantiate(viewModel: AllCoinsViewModel) -> AllCoinsViewController {
        let viewController = AllCoinsViewController.instantiateFromStoryboard()
        viewController.viewModel = viewModel
        return viewController
    }
    
    // MARK: - Configure
    private func configure() {
        configureCollectionView()
        configureInitialCoinCollection()
    }
    
    // MARK: - Configure Collection View
    private func configureCollectionView() {
        collectionView.register(UINib(nibName:"CoinCell", bundle: nil), forCellWithReuseIdentifier: CustomCellIdentifier.coinCell)
        collectionView.register(CoinCell.self, forCellWithReuseIdentifier: CustomCellIdentifier.coinCell)

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Configure Initial Coin Collection
    private func configureInitialCoinCollection() {
        viewModel.getAllCoins {
            self.collectionView.reloadData()
        }
    }
}

extension AllCoinsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.getCoinsCount())
        return viewModel.getCoinsCount()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellIdentifier.coinCell, for: indexPath) as? CoinCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}

extension AllCoinsViewController: Storyboardable {}
