//
//  Date+Extension.swift
//  CoinBucket
//
//  Created by Christopher Lee on 18/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

extension Date {
    func toString(dateFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
