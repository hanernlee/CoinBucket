//
//  CurrencyViewController+TableViewDelegate.swift
//  CoinBucket
//
//  Created by Christopher Lee on 19/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

extension CurrencyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if indexPath == selectedIndexPath! {
            return
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            let currency = currencies[indexPath.row]
            currency.checked = true
            stateController.currency = currency
            
            self.delegate?.didSelectCurrency(currency: currency)
            
            configureCheckmark(for: cell, with: currency)
        }
        
        if let oldCell = tableView.cellForRow(at: selectedIndexPath!) {
            let oldCurrency = currencies[(selectedIndexPath?.row)!]
            oldCurrency.checked = false
            
            configureCheckmark(for: oldCell, with: oldCurrency)
        }
        
        selectedIndexPath = indexPath
    }
}
