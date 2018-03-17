//
//  CurrencyFormatter.swift
//  CoinBucket
//
//  Created by Christopher Lee on 13/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation

protocol CurrencyFormatter {}

extension CurrencyFormatter {
    func formatCurrency(localeIdentifier: String) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: localeIdentifier)
        guard let newNumber = self as? NSNumber else { return "" }

        if (Double(truncating: newNumber) >= 1.00) {
            currencyFormatter.maximumFractionDigits = 2
        } else {
            currencyFormatter.maximumFractionDigits = 5
        }
        
        return currencyFormatter.string(from: newNumber)!
    }
    
    func toDecimals() -> String {
        let numberFormatter = NumberFormatter()
        guard let newNumber = self as? NSNumber else { return "" }
        
        if (Double(truncating: newNumber) >= 1.00) {
            numberFormatter.maximumFractionDigits = 2
        } else {
            numberFormatter.maximumFractionDigits = 5
        }

        return numberFormatter.string(from: newNumber)!
    }
}

extension Float: CurrencyFormatter {}
extension Double: CurrencyFormatter {}
extension NSDecimalNumber: CurrencyFormatter {}
