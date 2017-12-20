//
//  CurrencyViewController+TableViewDelegate.swift
//  Coinster
//
//  Created by Christopher Lee on 19/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

extension CurrencyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let currency = currencies[indexPath.row]
            currency.toggleChecked()
            
            configureCheckmark(for: cell, with: currency)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
