//
//  MainTabBarController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 9/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var stateController: StateController!

    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBarItems()
        tabBar.itemPositioning = .fill
    }

    // MARK: - Fileprivate Methods
    fileprivate func setupTabBarItems() {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.value(forKey: "currency") as? Data {
            var currencyDict = try? PropertyListDecoder().decode([String: Currency].self, from: data)
            
            let currency = currencyDict!["currency"]
            
            stateController = StateController(currency: Currency(name: (currency?.name)!, locale: (currency?.locale)!))
        } else {
            stateController = StateController(currency: Currency(name: "USD", locale: "en_US"))
        }
        
        let portfolioViewController = PortfolioViewController(collectionViewLayout: UICollectionViewFlowLayout())
        portfolioViewController.stateController = stateController
        let portfolioNavController = templateNavController(title: "Bucket", unselectedImage: #imageLiteral(resourceName: "bucket_unselected").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "bucket_selected"), rootViewController: portfolioViewController)
        
        let coinsViewController = CoinsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        coinsViewController.stateController = stateController
        let coinsNavController = templateNavController(title: "Coins", unselectedImage: #imageLiteral(resourceName: "coins_unselected").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "coins_selected"), rootViewController: coinsViewController)
        
        let settingsController = SettingsViewController()
        settingsController.stateController = stateController
        let settingsNavController = templateNavController(title: "Settings", unselectedImage: #imageLiteral(resourceName: "settings_unselected").withRenderingMode(.alwaysOriginal), selectedImage: #imageLiteral(resourceName: "settings_selected"), rootViewController: settingsController)
        
        viewControllers = [portfolioNavController, coinsNavController, settingsNavController]
    }
    
    // Templating Navigation Controllers
    fileprivate func templateNavController(title: String, unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
