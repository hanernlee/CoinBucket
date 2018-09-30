//
//  TabBarController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

public class TabBarController: UITabBarController {
    private let viewControllerFactory: ViewControllerFactory

    public override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    init(factory: ViewControllerFactory) {
        self.viewControllerFactory = factory
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.viewControllerFactory = nil
        super.init(coder: aDecoder)
    }
    
    private func configure() {
        let coinsViewController = configureTabViewController("Coins", unselectedImage: #imageLiteral(resourceName: "coins_unselected"), selectedImage: #imageLiteral(resourceName: "coins_selected") , rootViewController: viewControllerFactory.createAllCoinsViewController())
        viewControllers = [coinsViewController]
    }
    
    private func configureTabViewController(_ title: String, unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let viewController = rootViewController
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = unselectedImage
        navigationController.tabBarItem.selectedImage = selectedImage
        return navigationController
    }
}
