//
//  CurrencyViewController+TableViewDataSource.swift
//  Coinster
//
//  Created by Christopher Lee on 19/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

extension CurrencyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! CurrencyCell
        let currency = currencies[indexPath.row]
        
        if currency.name == selectedCurrency {
            currency.toggleChecked()
        }
        
        configureCheckmark(for: cell, with: currency)
        cell.displayCurrencyInCell(using: currency)
        return cell
    }
}
