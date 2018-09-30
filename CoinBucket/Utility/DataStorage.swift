//
//  DataStorage.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

public protocol DataStorageProtocol {
    func setValue<T>(_ value: T, forKey key: DataStorageKey<T>)
    func getValue<T>(forKey key: DataStorageKey<T>) -> T
    func removeValue<T>(forKey key: DataStorageKey<T>)
}

public enum DataStoreOption {
    case userDefaults
}

public struct DataStorageKey<T> {
    public let key: String
    public let dataStoreOption: DataStoreOption
    public let defaultValue: T
    
    public init(_ key: String, dataStoreOption: DataStoreOption, valueType: T.Type, defaultValue: T) {
        self.key = key
        self.dataStoreOption = dataStoreOption
        self.defaultValue = defaultValue
    }
}

class DataStorage: DataStorageProtocol {
    private let userDefaults: UserDefaults
    
    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    public func setValue<T>(_ value: T, forKey key: DataStorageKey<T>) {
        userDefaults.set(value, forKey: key.key)
    }
    
    public func getValue<T>(forKey key: DataStorageKey<T>) -> T {
        return userDefaults.object(forKey: key.key) as? T ?? key.defaultValue
    }
    
    public func removeValue<T>(forKey key: DataStorageKey<T>) {
        userDefaults.removeObject(forKey: key.key)
    }
}
