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
        let currency = currencies[indexPath.row]
        currency.toggleChecked()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath == selectedIndexPath {
            return
        }
        
        let newCell = tableView.cellForRow(at: indexPath)
        if newCell?.accessoryType == .none {
            print("sekecckck")
            newCell?.accessoryType = .checkmark
        }
        let oldCell = tableView.cellForRow(at: selectedIndexPath!)
        if oldCell?.accessoryType == .checkmark {
            oldCell?.accessoryType = .none
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
        selectedIndexPath = indexPath
    }
}
