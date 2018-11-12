//
//  Suggestion.swift
//  CoinBucket
//
//  Created by Christopher Lee on 11/11/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation

struct SuggestionResult: Decodable {
    let result: [Suggestion]
    
    private enum CodingKeys : String, CodingKey {
        case result = "Results"
    }
}

struct Suggestion: Decodable {
    let name: String
    let group: String
    let fullPath: String
    
    private enum CodingKeys : String, CodingKey {
        case name = "nodeName"
        case group
        case fullPath
    }
}
