//
//  SuggestionCellViewModel.swift
//  CoinBucket
//
//  Created by Christopher Lee on 11/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation
import UIKit

class SuggestionCellViewModel {
    let name: String
    let symbol: String
    let networkService: NetworkService
    let environmentService: EnvironmentServiceProtocol
    
    let regexPattern = "(?<=\\()[^()]{1,10}(?=\\))"
    
    init(model: Suggestion, networkService: NetworkService, environmentService: EnvironmentServiceProtocol) {
        self.name = model.name
        self.symbol = SuggestionCellViewModel.matches(for: regexPattern, in: model.name)[0]
        self.networkService = networkService
        self.environmentService = environmentService
    }
    
    func getCoin(completion: @escaping ([ConstructedCoin]) -> Void) {
        networkService.getCoin(symbols: [symbol], currency: environmentService.currency) { (result) in
            
            switch result {
            case .Success(let constructedCoins):
                completion(constructedCoins)
            case .Error:
                print("Failed")
            }
        }
    }
    
    static func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
