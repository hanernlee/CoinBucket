//
//  EnvironmentService.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

protocol EnvironmentServiceProtocol {
    var theme: String { get set }
    func reset()
}

class EnvironmentService: EnvironmentServiceProtocol {
    private let dataStorage: DataStorage = DataStorage()
    
    public func reset() {
        dataStorage.removeValue(forKey: DataStorageKeys.theme)
    }
    
    var theme : String {
        get { return dataStorage.getValue(forKey: DataStorageKeys.theme)}
        set { dataStorage.setValue(newValue, forKey: DataStorageKeys.theme) }
    }
}
