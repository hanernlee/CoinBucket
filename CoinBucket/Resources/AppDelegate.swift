//
//  AppDelegate.swift
//  CoinBucket
//
//  Created by Christopher Lee on 9/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let networkService = NetworkService()
        let enviromentService = EnvironmentService()
        let viewControllerFactory = ViewControllerFactory(environmentService: enviromentService, networkService: networkService)
        let tabBarController = TabBarController()
        tabBarController.viewControllerFactory = viewControllerFactory
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        return true
    }
}

