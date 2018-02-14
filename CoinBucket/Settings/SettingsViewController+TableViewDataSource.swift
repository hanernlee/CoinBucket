//
//  SettingsViewController+TableViewDataSource.swift
//  CoinBucket
//
//  Created by Christopher Lee on 19/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
// Commenting out Nightmode
//        case 1: return 1
        default: fatalError("Unknown number of sections")
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
// Commenting out Nightmode
//        return 2
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! SettingCell
            cell.setupCell(with: stateController.currency)
            return cell
// Commenting out Nightmode
//        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! SettingCell
//            return cell
        default: fatalError("Unknown section")
        }
    }
}
