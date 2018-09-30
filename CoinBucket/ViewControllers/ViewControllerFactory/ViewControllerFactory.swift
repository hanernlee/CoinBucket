//
//  ViewControllerFactory.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

public struct ViewControllerFactory {
    private let environmentService: EnvironmentServiceProtocol
    private let networkService: NetworkService
    
    init (environmentService: EnvironmentServiceProtocol, networkService: NetworkService) {
        self.environmentService = environmentService
        self.networkService = networkService
    }
    
    func createAllCoinsViewController() -> AllCoinsViewController {
        let viewModel = AllCoinsViewModel(environmentService: environmentService, networkService: networkService)
        return AllCoinsViewController.instantiate(viewModel: viewModel)
    }
}
