//
//  AddToBucketLauncher.swift
//  CoinBucket
//
//  Created by Christopher Lee on 18/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

class AddToBucketLauncher: NSObject {

    // MARK: - Properties

    private let coin: Coin
    private let environmentService: EnvironmentServiceProtocol
    private let dimBackgroundView: UIView!
    private let tallyView: TallyView!
        
    init(coin: Coin, environmentService: EnvironmentServiceProtocol) {
        self.coin = coin
        self.environmentService = environmentService
        self.dimBackgroundView = UIView()
        
        let viewModel = TallyViewViewModel(coin: coin, environmentService: environmentService)
        let tallyView = TallyView.instantiate(with: viewModel)
        self.tallyView = tallyView
        super.init()
    }
    
    public func showAddToBucketView() {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        // DimBackgroundVie Configuration
        dimBackgroundView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        dimBackgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideAddToBucketView)))
        
        window.addSubview(dimBackgroundView)
        dimBackgroundView.frame = window.frame
        dimBackgroundView.alpha = 0

        // TallyView
        let height: CGFloat = 220
        let width = window.frame.width
        let computedY = window.frame.height - height
        tallyView.frame = CGRect(x: 0, y: window.frame.height, width: width, height: height)
        tallyView.didSaveToBucket = { [weak self] in
            self?.hideAddToBucketView()
        }
        window.addSubview(tallyView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.dimBackgroundView.alpha = 1
            self.tallyView.frame = CGRect(x: 0, y: computedY, width: width, height: height)
        }, completion: nil)
    }
    
    @objc public func hideAddToBucketView() {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        tallyView.countTextField.resignFirstResponder()
        tallyView.reconfigureCount()

        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.dimBackgroundView.alpha = 0
            self.tallyView.frame = CGRect(x: 0, y: window.frame.height, width: self.tallyView.frame.width, height: self.tallyView.frame.height)
        }, completion: nil)
    }
    
    public func handleKeyboardShown(with height: CGFloat) {
        self.tallyView.frame = CGRect(x: 0, y: height + 70, width: self.tallyView.frame.width, height: self.tallyView.frame.height)

        UIView.animate(withDuration: 0.5) {
            self.tallyView.layoutIfNeeded()
        }
    }
    
    public func handleKeyboardHidden() {
        guard let window = UIApplication.shared.keyWindow else { return }
        
        let height: CGFloat = 220
        let width = window.frame.width
        let computedY = window.frame.height - height

        tallyView.reconfigureCount()

        self.tallyView.frame = CGRect(x: 0, y: computedY, width: width, height: height)

        UIView.animate(withDuration: 0.5) {
            self.tallyView.layoutIfNeeded()
        }
    }
}
