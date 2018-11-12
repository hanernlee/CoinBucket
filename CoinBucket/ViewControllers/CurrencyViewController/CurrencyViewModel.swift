//
//  CurrencyViewModel.swift
//  CoinBucket
//
//  Created by Christopher Lee on 4/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

public class CurrencyViewModel {
    private var environmentService: EnvironmentServiceProtocol
    private var currencies: [String] = []
    private var filteredCurrencies: [String] = []
    
    init(environmentService: EnvironmentServiceProtocol) {
        self.environmentService = environmentService
    }
    
    func configureCell(cell: CurrencyCell, at index: Int) {
        let currency = Currency(name: filteredCurrencies[index])
        let currencyViewModel = CurrencyCellViewModel(model: currency, systemCurrency: environmentService.currency)
        cell.configure(using: currencyViewModel)
    }
    
    func getCurrencies() {
        guard let currencies = Currencies.getCurrencies() else { return }
        self.currencies = currencies
        self.filteredCurrencies = currencies
    }
    
    func getCurrenciesCount() -> Int {
        return filteredCurrencies.count
    }
    
    func getSelectedCurrency() -> String {
        return environmentService.currency
    }
    
    func selectCell(at index: Int) {
        environmentService.currency = filteredCurrencies[index]
    }
    
    func filterCurrencies(searchText: String, completion: @escaping () -> Void) {
        guard searchText.isEmpty == false else {
            filteredCurrencies = currencies
            return completion()
        }
        
        filteredCurrencies = currencies.filter { $0.lowercased().contains(searchText.lowercased()) }
        completion()
    }
}
