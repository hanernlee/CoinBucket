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
        collectionView.backgroundColor = .bgGray

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
        
        viewModel.getCoins { [weak self] in
            guard let `self` = self else { return }
            
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

        viewModel.configureCell(cell: cell, at: indexPath.item)

        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.getCoinsCount() - 1 &&
            viewModel.isLoadingNextPage == false &&
            viewModel.hasLoadedAllCoins == false {
                self.view.showLoadingIndicator()

                viewModel.getCoins { [weak self] in
                    guard let `self` = self else { return }

                    self.view.hideLoadingIndicator()
                    self.collectionView.reloadData()
                }
        }
    }
    
//    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
//            if let cell = collectionView.cellForItem(at: indexPath) as? CoinCell {
//                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
//            }
//        }, completion: nil)
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
//            if let cell = collectionView.cellForItem(at: indexPath) as? CoinCell {
//                cell.transform = .identity
//            }
//        }, completion: nil)
//    }
}

extension AllCoinsViewController: Storyboardable {}
