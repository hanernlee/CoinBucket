//
//  Array+chunked.swift
//  CoinBucket
//
//  Created by Christopher Lee on 4/10/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
