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
    
    var currencies = [Currency]()

    let availableCurrencies = [
        "AUD": "en_AU",
        "BRL": "pt_BR",
        "CAD": "en_CA",
        "CHF": "en_CH",
        "CLP": "es_CL",
        "CNY": "zh_CN",
        "CZK": "en_CZ",
        "DKK": "en_DK",
        "EUR": "eu_ES",
        "GBP": "en_GB",
        "HKD": "en_HK",
        "HUF": "en_HU",
        "IDR": "id_ID",
        "ILS": "he_IL",
        "INR": "en_IN",
        "JPY": "ja_JP",
        "KRW": "ko_KR",
        "MXN": "es_MX",
        "MYR": "ms_MY",
        "NOK": "en_NO",
        "NZD": "en_NZ",
        "PHP": "en_PH",
        "PKR": "en_PK",
        "PLN": "en_PL",
        "RUB": "en_RU",
        "SEK": "en_SE",
        "SGD": "en_SG",
        "THB": "th_TH",
        "TRY": "en_TR",
        "TWD": "zh_TW",
        "USD": "en_US",
        "ZAR": "en_ZA"
    ]
    
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
            let currency = Currency(name: currency.key, locale: currency.value)
            
            currencies.append(currency)
        }

        currencies = currencies.sorted(by: { $0.name < $1.name })
        
        for (i ,currency) in currencies.enumerated() {
            if currency.name == stateController.currency.name {
                currency.toggleChecked()
                selectedIndexPath = IndexPath(row: i, section: 0)
            }
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
