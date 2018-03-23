//
//  SettingsViewController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 19/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    let alertController: UIAlertController = {
        let alert = UIAlertController(title: "Mail Error", message: "Unabler to send mail. Please set up a mail account and try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }()
    
    let tableCell = "TableCell"
    let mailCell = "MailCell"

    var stateController: StateController!
    var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Settings"

        registerTableView()
    }
    
    func registerTableView() {
        tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.grouped)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.allowsMultipleSelection = false
        tableView?.register(SettingCell.self, forCellReuseIdentifier: tableCell)
        tableView?.register(MailCell.self, forCellReuseIdentifier: mailCell)

        view.addSubview(tableView!)
    }
}

extension SettingsViewController: CurrencyViewControllerDelegate {
    func didSelectCurrency(currency: Currency) {
        stateController.currency = currency
        tableView?.reloadData()
    }
}
