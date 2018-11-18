//
//  DataStorageKeys.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

public struct DataStorageKeys {
    static let theme = DataStorageKey("Theme", dataStoreOption: .userDefaults, valueType: String.self, defaultValue: "orange")
    static let currency = DataStorageKey("Currency", dataStoreOption: .userDefaults, valueType: String.self, defaultValue: "USD")
    static let bucket = DataStorageKey("Bucket", dataStoreOption: .userDefaults, valueType: [String: Float].self, defaultValue: [:])
}
