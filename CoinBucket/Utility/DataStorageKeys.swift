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
}
