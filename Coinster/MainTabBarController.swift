//
//  MainTabBarController.swift
//  Coinster
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
    }

    // MARK: - Fileprivate Methods
    fileprivate func setupTabBarItems() {
        let stateController = StateController(currency: Currency(name: "USD"))
        
        let coinsViewController = CoinsViewController(collectionViewLayout: UICollectionViewFlowLayout())
        coinsViewController.stateController = stateController
        let coinsNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: coinsViewController)
        
        let settingsController = SettingsViewController()
        print(stateController)
        settingsController.stateController = stateController
        let settingsNavController = templateNavController(unselectedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: settingsController)
        
        viewControllers = [coinsNavController, settingsNavController]
    }
    
    // Templating Navigation Controllers
    fileprivate func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
