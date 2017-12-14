//
//  CurrencyFormatter.swift
//  Coinster
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
        currencyFormatter.maximumFractionDigits = 3
        currencyFormatter.locale = Locale(identifier: localeIdentifier)
        guard let newNumber = self as? NSNumber else { return "" }
        return currencyFormatter.string(from: newNumber)!
    }
}

extension Double: CurrencyFormatter {}
extension NSDecimalNumber: CurrencyFormatter {}
