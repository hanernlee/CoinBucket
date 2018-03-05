//
//  PortfolioViewController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 9/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import UIKit

class PortfolioViewController: UIViewController {
    
    var stateController: StateController!
    
    let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .groupTableViewBackground
        navigationItem.title = "Portfolio"
        
        configureUI()

    }
    
    fileprivate func configureUI() {
        view.addSubview(emptyView)
        emptyView.frame = CGRect(x: 0, y: (navigationController?.navigationBar.frame.height)! + 40, width: view.frame.width, height: view.frame.height / 2 - 50)
    }
}
