//
//  TabBarController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

public class TabBarController: UITabBarController {
    private var viewControllerFactory: ViewControllerFactory

    public override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    public init(factory: ViewControllerFactory) {
        self.viewControllerFactory = factory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        UITabBar.appearance().tintColor = .orangey

        let bucketViewController = configureTabViewController("Bucket", unselectedImage: #imageLiteral(resourceName: "bucket_unselected"), selectedImage: #imageLiteral(resourceName: "bucket_selected"), rootViewController: viewControllerFactory.createBucketViewController())
        let coinsViewController = configureTabViewController("Coins", unselectedImage: #imageLiteral(resourceName: "coins_unselected"), selectedImage: #imageLiteral(resourceName: "coins_selected") , rootViewController: viewControllerFactory.createAllCoinsViewController())
        let settingViewController = configureTabViewController("Settings", unselectedImage: #imageLiteral(resourceName: "settings_unselected"), selectedImage: #imageLiteral(resourceName: "settings_selected") , rootViewController: viewControllerFactory.createSettingsViewController())
        viewControllers = [bucketViewController, coinsViewController, settingViewController]
    }
    
    private func configureTabViewController(_ title: String, unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let viewController = rootViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.tintColor = .orangey
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = unselectedImage
        navigationController.tabBarItem.selectedImage = selectedImage
        return navigationController
    }
}
