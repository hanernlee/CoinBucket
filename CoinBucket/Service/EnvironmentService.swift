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
    var currency: String { get set }
    var bucket: [String: Float] { get set }
    func reset()
}

class EnvironmentService: EnvironmentServiceProtocol {
    private let dataStorage: DataStorage = DataStorage()
    
    public func reset() {
        dataStorage.removeValue(forKey: DataStorageKeys.currency)
        dataStorage.removeValue(forKey: DataStorageKeys.theme)
        dataStorage.removeValue(forKey: DataStorageKeys.bucket)
    }
    
    var theme: String {
        get { return dataStorage.getValue(forKey: DataStorageKeys.theme)}
        set { dataStorage.setValue(newValue, forKey: DataStorageKeys.theme) }
    }
    
    var currency: String {
        get { return dataStorage.getValue(forKey: DataStorageKeys.currency)}
        set { dataStorage.setValue(newValue, forKey: DataStorageKeys.currency) }
    }
    
    var bucket: [String: Float] {
        get { return dataStorage.getValue(forKey: DataStorageKeys.bucket)}
        set { dataStorage.setValue(newValue, forKey: DataStorageKeys.bucket) }
    }
}
