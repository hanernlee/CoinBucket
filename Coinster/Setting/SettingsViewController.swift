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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        registerTableView()
    }
    
    func registerTableView() {
        let tableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
    }
}
