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
        configureNavigationTitle()
        configureCollectionView()
        configureInitialCoinCollection()
    }
    
    // MARK: - Configure Navigation Title
    private func configureNavigationTitle() {
        navigationItem.title = "Coins"
    }
    
    // MARK: - Configure CollectionView
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CoinCell", bundle: nil), forCellWithReuseIdentifier: CustomCellIdentifier.coinCell)
        configureCollectionViewFlowLayout()
    }
    
    // MARK: - Configure CollectionViewFlowLayout

    private func configureCollectionViewFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width - 24, height: 70)
        collectionView.collectionViewLayout = layout
    }
    
    // MARK: - Configure Initial Coin Collection
    private func configureInitialCoinCollection() {
        self.view.showLoadingIndicator()

        viewModel.getAllCoins {
            self.view.hideLoadingIndicator()
            self.collectionView.reloadData()
        }
    }
}

extension AllCoinsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
