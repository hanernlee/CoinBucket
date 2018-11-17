//
//  CoinDetailsViewController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 12/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class CoinDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinFullName: UILabel!
    @IBOutlet weak var coinSymbol: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceBTCLabel: UILabel!
    @IBOutlet weak var percentageChangeLabel: UILabel!
    @IBOutlet weak var percentageChangeBTCLabel: UILabel!
    
    // First Grid View
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var volume24hLabel: UILabel!
    
    // Second Grid View
    @IBOutlet weak var supplyLabel: UILabel!
    @IBOutlet weak var volume24hToLabel: UILabel!
    @IBOutlet weak var volume24hToTitleLabel: UILabel!
    
    // Third Grid View
    @IBOutlet weak var totalVolume24hLabel: UILabel!
    @IBOutlet weak var totalVolume24hToLabel: UILabel!
    @IBOutlet weak var totalVolume24hToTitleLabel: UILabel!
    
    // Fourth Grid View
    @IBOutlet weak var open24hLabel: UILabel!
    @IBOutlet weak var lowHigh24hLabel: UILabel!
    
    // MARK: - Properties
    
    private var viewModel: CoinDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    public static func instantiate(viewModel: CoinDetailsViewModel) -> CoinDetailsViewController {
        let viewController = CoinDetailsViewController.instantiateFromStoryboard()
        viewController.viewModel = viewModel
        return viewController
    }
    
    private func configure() {
        view.backgroundColor = .bgGray
        
        configureNavigationBar()
        configureDetails()
        configureGridView()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "\(viewModel.fullName) - \(viewModel.environmentService.currency)"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
    }
    
    private func configureDetails() {
        coinFullName.text = viewModel.fullName
        coinSymbol.text = "(\(viewModel.name))"

        priceLabel.text = viewModel.price
        percentageChangeLabel.text = "\(viewModel.changePercent24Hour)%"
        percentageChangeLabel.textColor = viewModel.percentageChangeColor()

        priceBTCLabel.text = viewModel.priceBTC
        percentageChangeBTCLabel.text = "\(viewModel.changePercent24HourBTC)%"
        percentageChangeBTCLabel.textColor = viewModel.percentageChangeBTCColor()
        
        configureImage(viewModel.imageUrl)
    }
    
    private func configureGridView() {
        // First Grid View
        marketCapLabel.text = viewModel.marketCap
        supplyLabel.text = viewModel.supply

        // Second Grid View
        volume24hLabel.text = viewModel.volume24H
        volume24hToLabel.text = viewModel.volume24HTO
        volume24hToTitleLabel.text = "Volume (24h) \(viewModel.environmentService.currency)"
        
        // Third Grid View
        totalVolume24hLabel.text = viewModel.totalVolume24H
        totalVolume24hToLabel.text = viewModel.totalVolume24HTO
        totalVolume24hToTitleLabel.text = "Total Volume (24h) \(viewModel.environmentService.currency)"
        
        // Fourth Grid View
        open24hLabel.text = viewModel.priceOpen24Hour
        lowHigh24hLabel.text = "\(viewModel.priceLow24Hour) - \(viewModel.priceHigh24Hour)"
    }
    
    private func configureImage(_ imageUrl: String) {
        guard let url = URL(string: "\(APIClient.baseUrl)\(imageUrl)"), let placeholderImage = UIImage(named: "coin_deposit") else {
            return
        }
        coinImage.af_setImage(withURL: url, placeholderImage: placeholderImage)
    }
}

extension CoinDetailsViewController: Storyboardable {}
