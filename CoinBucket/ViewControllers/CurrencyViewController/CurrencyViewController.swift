//
//  CurrencyViewController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 4/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

public class CurrencyViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private let searchController = UISearchController(searchResultsController: nil)
    private var viewModel: CurrencyViewModel!

    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Instantiate
    public static func instantiate(viewModel: CurrencyViewModel) -> CurrencyViewController {
        let viewController = CurrencyViewController.instantiateFromStoryboard()
        viewController.viewModel = viewModel
        return viewController
    }
    
    // MARK: - Configure
    private func configure() {
        configureNavigationBar()
        configureSearchController()
        configureTableView()
        
        viewModel.getCurrencies()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Currency"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(dismissView))
    }
    
    private func configureSearchController() {
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = .orangey
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.tintColor = .orangey
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .bgGray
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: CustomCellIdentifier.currencyCell)
    }
    
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}

extension CurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifier.currencyCell, for: indexPath) as? CurrencyCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none

        viewModel.configureCell(cell: cell, at: indexPath.item)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            guard let cell = tableView.cellForRow(at: indexPath) as? CurrencyCell else { return }
            cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.viewModel.selectCell(at: indexPath.row)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                guard let cell = tableView.cellForRow(at: indexPath) as? CurrencyCell else { return }
                cell.transform = .identity
                tableView.reloadData()
            }, completion: nil)
        })
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCurrenciesCount()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "SELECTED CURRENCY: \(viewModel.getSelectedCurrency())"
        
        let headerView = UIView()
        headerView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: headerView.topAnchor),
            label.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 16),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            label.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: 16),
        ])
        
        headerView.backgroundColor = .bgGray
        return headerView
    }
}

extension CurrencyViewController: UISearchBarDelegate, UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        
        viewModel.filterCurrencies(searchText: searchText) { [weak self] in
            guard let `self` = self else { return }

            self.tableView.reloadData()
        }
    }
}

extension CurrencyViewController: Storyboardable {}
