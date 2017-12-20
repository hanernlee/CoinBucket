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
        
        print(selectedCurrency)
        print(currency.name)
        
        if (selectedCurrency == currency.name) {
            print(currency)
            selectedIndexPath = IndexPath(row: indexPath.row, section: 0)
        }
        print(selectedIndexPath)
        
        if indexPath == selectedIndexPath {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        let currencyViewModel = CurrencyViewModel(model: currency)
        cell.displayCurrencyInCell(using: currencyViewModel)
        return cell
    }
}
