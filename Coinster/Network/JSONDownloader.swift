//
//  JSONDownloader.swift
//  Coinster
//
//  Created by Christopher Lee on 12/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation

enum Result<T> {
    case Success(T)
    case Error(NetworkError)
}

enum NetworkError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case invalidURL
    case jsonParsingFailure
}

struct JSONDownloader {
    let session: URLSession
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    init() {
        self.init(configuration: .default)
    }
    typealias JSON = Data
    typealias JSONTaskCompletionHandler = (Result<JSON>) -> ()
    
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.Error(.requestFailed))
                return
            }
            if httpResponse.statusCode == 200 {
                if let data = data {
                    completion(.Success(data))
                } else {
                    completion(.Error(.invalidData))
                }
            } else {
                completion(.Error(.responseUnsuccessful))
            }
        }
        return task
    }
}
