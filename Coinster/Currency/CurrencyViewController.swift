//
//  CurrencyViewController.swift
//  Coinster
//
//  Created by Christopher Lee on 19/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
    let tableCell = "tableCell"
    
    var currentCurrency = "AUD"
    
    let availableCurrencies = ["AUD", "BRL", "CAD", "CHF", "CLP", "CNY", "CZK", "DKK", "EUR", "GBP", "HKD", "HUF", "IDR", "ILS", "INR", "JPY", "KRW", "MXN", "MYR", "NOK", "NZD", "PHP", "PKR", "PLN", "RUB", "SEK", "SGD", "THB", "TRY", "TWD", "ZAR"]
    
    var currencies = [Currency]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Currencies"
        
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
        for currency in availableCurrencies {
            let currency = Currency(currency: currency)
            currencies.append(currency)
        }
    }
}
