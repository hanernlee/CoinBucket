//
//  AllCoinsViewController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

public class AllCoinsViewController: UITableViewController {
    private var viewModel: AllCoinsViewModel! = nil
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    public func configure() {
        view.backgroundColor = .yellow
        
    }
    
    public static func instantiate(viewModel: AllCoinsViewModel) -> AllCoinsViewController {
        let viewController = AllCoinsViewController.instantiateFromStoryboard()
        viewController.viewModel = viewModel
        return viewController
    }
}

extension AllCoinsViewController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}

extension AllCoinsViewController: Storyboardable {}
