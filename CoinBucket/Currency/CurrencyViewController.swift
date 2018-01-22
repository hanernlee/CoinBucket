//
//  CurrencyViewController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 19/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

protocol CurrencyViewControllerDelegate {
    func didSelectCurrency(currency: Currency)
}

class CurrencyViewController: UIViewController {
    var delegate: CurrencyViewControllerDelegate?
    var stateController: StateController!
    var selectedIndexPath: IndexPath?
    let tableCell = "tableCell"

    let availableCurrencies = ["AUD", "BRL", "CAD", "CHF", "CLP", "CNY", "CZK", "DKK", "EUR", "GBP", "HKD", "HUF", "IDR", "ILS", "INR", "JPY", "KRW", "MXN", "MYR", "NOK", "NZD", "PHP", "PKR", "PLN", "RUB", "SEK", "SGD", "THB", "TRY", "TWD", "USD", "ZAR"]
    
    var currencies = [Currency]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Currencies"
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: nil, action: nil)
        
        createCurrencies()
        registerTableView()
    }
    
    func registerTableView() {
        let tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: tableCell)
        
        view.addSubview(tableView)
    }
    
    func createCurrencies() {
        for (i, currency) in availableCurrencies.enumerated() {
            let currency = Currency(name: currency)
            
            if currency.name == stateController.currency.name {
                currency.toggleChecked()
                selectedIndexPath = IndexPath(row: i, section: 0)
            }
            
            currencies.append(currency)
        }
    }
    
    func configureCheckmark(for cell: UITableViewCell, with currency: Currency) {
        if currency.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
}
