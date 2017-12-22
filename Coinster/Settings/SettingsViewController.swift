//
//  SettingsViewController.swift
//  Coinster
//
//  Created by Christopher Lee on 19/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    let tableCell = "tableCell"
    
    var currency: Currency?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Settings"

        registerTableView()
    }
    
    func registerTableView() {
        let tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsMultipleSelection = false
        tableView.register(SettingCell.self, forCellReuseIdentifier: tableCell)

        view.addSubview(tableView)
    }
}

extension SettingsViewController: CurrencyViewControllerDelegate {
    func didSelectCurrency(currency: Currency) {
        print(currency)
    }
}
