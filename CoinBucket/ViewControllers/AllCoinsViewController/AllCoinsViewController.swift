//
//  AllCoinsViewController.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

public class AllCoinsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Private properties
    private let searchController = UISearchController(searchResultsController: nil)
    private var viewModel: AllCoinsViewModel!
    private var refreshControl: UIRefreshControl?
    
    private let searchTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let emptyView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    lazy var currencyRightButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(presentCurrencySelection), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.configureRefreshControlText()
        configure()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBar()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        currencyRightButton.removeFromSuperview()
    }
    
    // MARK: - Instantiate
    public static func instantiate(viewModel: AllCoinsViewModel) -> AllCoinsViewController {
        let viewController = AllCoinsViewController.instantiateFromStoryboard()
        viewController.viewModel = viewModel
        return viewController
    }
    
    // MARK: - Configure
    private func configure() {
        configureSearchController()
        configureCollectionView()
        configureInitialCoinCollection()
    }
    
    // MARK: - Configure Navigation Title
    private func configureNavigationBar() {
        navigationItem.title = "Coins"
        
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.addSubview(currencyRightButton)

        currencyRightButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            currencyRightButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -6),
            currencyRightButton.rightAnchor.constraint(equalTo: navigationBar.rightAnchor, constant: -16)
        ])
        
        configureCurrency()
    }
    
    private func configureSearchController() {
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.definesPresentationContext = true
        searchController.searchBar.tintColor = .orangey

        definesPresentationContext = true

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - Configure Currency
    private func configureCurrency() {
        viewModel.shouldRefreshCurrency { [weak self] (shouldRefresh) in
            guard let `self` = self, shouldRefresh else { return }
            
            self.view.hideLoadingIndicator()
            
            self.configureInitialCoinCollection()
        }

        currencyRightButton.setTitle(viewModel.getSelectedCurrency(), for: .normal)
    }
    
    // MARK: - Configure CollectionView
    private func configureCollectionView() {
        collectionView.backgroundColor = .bgGray
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CoinCell", bundle: nil), forCellWithReuseIdentifier: CustomCellIdentifier.coinCell)
        configureRefreshControl()

        configureCollectionViewFlowLayout()
    }
    
    // MARK: - Configure CollectionViewFlowLayout

    private func configureCollectionViewFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width - 32, height: 70)
        collectionView.collectionViewLayout = layout
    }
    
    // MARK: - Configure Initial Coin Collection
    private func configureInitialCoinCollection() {
        self.view.showLoadingIndicator()
        
        viewModel.getCoins { [weak self] in
            guard let `self` = self else { return }
            
            self.refreshControl?.attributedTitle = self.viewModel.refreshControlText
            self.view.hideLoadingIndicator()
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Present Currency View Controller
    @objc private func presentCurrencySelection() {
        let currencyViewController = viewModel.createCurrencyViewController()
        let navigationController = UINavigationController(rootViewController: currencyViewController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: - Configure Background Collection View
    @objc private func configureBackgroundCollectionView() {
        searchTableView.reloadData()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.tableFooterView = UIView()
        searchTableView.backgroundColor = .bgGray
        searchTableView.register(UINib(nibName: "SuggestionCell", bundle: nil), forCellReuseIdentifier: CustomCellIdentifier.suggestionCell)
        searchTableView.register(UINib(nibName: "SuggestionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: CustomCellIdentifier.suggestionHeaderView)
        collectionView.alwaysBounceVertical = false
        searchTableView.alwaysBounceVertical = true
        
        if let navigationBarFrame = navigationController?.navigationBar.frame {
            let edgeInsets = UIEdgeInsets(top: -navigationBarFrame.origin.y, left: 0, bottom: 0, right: 0)
            searchTableView.contentInset = edgeInsets
            searchTableView.scrollIndicatorInsets = edgeInsets
        }
        
        loadSuggestions()

        collectionView?.backgroundView = self.searchTableView
    }
    
    // MARK: - Configure Empty View

    private func configureEmptyView() {
        emptyLabel.text = """
        No results found for "\(self.viewModel.getSearchText())"
        """
        
        emptyView.addSubview(emptyLabel)
        searchTableView.backgroundView = emptyView
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyLabel.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 16),
            emptyLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 16),
            emptyLabel.bottomAnchor.constraint(equalTo: emptyView.bottomAnchor, constant: 0),
            emptyLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: 16)
        ])
    }
    
    private func configureRefreshControl() {
        removeRefreshControl()

        refreshControl = UIRefreshControl()
        guard let refreshControl = refreshControl else { return }

        refreshControl.attributedTitle = viewModel.refreshControlText
        refreshControl.tintColor = .clear
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }

    private func removeRefreshControl() {
        refreshControl?.removeTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = nil
        self.refreshControl?.removeFromSuperview()
        self.refreshControl = nil
    }

    // MARK: - Refresh
    @objc private func handleRefresh() {
        collectionView?.backgroundView = nil
        
        refreshControl?.beginRefreshing()

        viewModel.isRefreshing = true
        self.view.showLoadingIndicator()

        viewModel.getCoins { [weak self] in
            guard let `self` = self else { return }
            
            self.refreshControl?.endRefreshing()
            self.refreshControl?.attributedTitle = self.viewModel.refreshControlText

            self.viewModel.isRefreshing = false
            self.view.hideLoadingIndicator()
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Reload Suggestion
    private func loadSuggestions() {
        self.view.showLoadingIndicator()
        
        self.searchTableView.backgroundView = nil

        viewModel.getSuggestions(with: viewModel.getSearchText()) { [weak self] count in
            guard let `self` = self else { return }

            self.view.hideLoadingIndicator()

            if count == 0 {
                self.configureEmptyView()
            }
            
            self.searchTableView.reloadData()
        }
    }
}

// MARK: - Collection View

extension AllCoinsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCoinsCount()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationItem.rightBarButtonItem = nil
        let coinDetailsViewController = viewModel.createCoinDetailsViewController(for: indexPath.item)
        navigationController?.pushViewController(coinDetailsViewController, animated: true)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCellIdentifier.coinCell, for: indexPath) as? CoinCell else {
                return UICollectionViewCell()
            }
            
            viewModel.configureCoinCell(cell: cell, at: indexPath.item)
            
            return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.getCoinsCount() - 1 &&
            viewModel.isLoadingNextPage == false &&
            viewModel.hasLoadedAllCoins == false &&
            viewModel.isFiltering == false {
                self.view.showLoadingIndicator()

                viewModel.getCoins { [weak self] in
                    guard let `self` = self else { return }

                    self.view.hideLoadingIndicator()
                    self.collectionView.reloadData()
                }
        }
    }
}

// MARK: - Table View

extension AllCoinsViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getSuggestionCount()
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard viewModel.hasSuggestions(),
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomCellIdentifier.suggestionHeaderView) as? SuggestionHeaderView else {
            return UIView()
        }

        viewModel.configureSuggestionHeaderLabel(headerView: headerView)

        return headerView
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCellIdentifier.suggestionCell, for: indexPath) as? SuggestionCell else {
            return UITableViewCell()
        }

        viewModel.didTapSuggestionCell = { [weak self] in
            guard let `self` = self else { return }
            self.collectionView?.alwaysBounceVertical = true
            self.searchTableView.alwaysBounceVertical = false

            self.view.hideLoadingIndicator()

            self.collectionView.reloadData()
        }
        
        viewModel.configureSuggestionCell(cell: cell, at: indexPath.item)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SuggestionCell else { return }
        self.view.showLoadingIndicator()
        self.collectionView?.backgroundView = nil
        viewModel.selectSuggestionCell(cell: cell, at: indexPath.row)
        self.searchTableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 33
    }
}

// MARK: - Search Controller

extension AllCoinsViewController: UISearchBarDelegate, UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        self.view.hideLoadingIndicator()

        viewModel.updateSearchText(with: searchController.searchBar.text ?? "")
        
        collectionView?.backgroundView = nil
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.configureBackgroundCollectionView), object: nil)
        
        viewModel.filterCoins() { [weak self] count in
            guard let `self` = self else { return }
            
            if count == 0 && self.viewModel.isLoadingNextPage == false {
                self.perform(#selector(self.configureBackgroundCollectionView), with: nil, afterDelay: 0.5)
            }
            
            self.collectionView.reloadData()
        }
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        collectionView?.backgroundView = nil
        viewModel.isFiltering = false
        configureRefreshControl()
    }
    
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.isFiltering = true
        removeRefreshControl()
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        collectionView?.backgroundView = nil
        viewModel.isFiltering = false
        configureRefreshControl()
    }
}

extension AllCoinsViewController: Storyboardable {}
