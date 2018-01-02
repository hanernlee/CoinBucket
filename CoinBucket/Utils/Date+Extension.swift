//
//  Date+Extension.swift
//  CoinBucket
//
//  Created by Christopher Lee on 15/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation

extension Date {
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
