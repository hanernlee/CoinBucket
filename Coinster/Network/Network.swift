//
//  Network.swift
//  Coinster
//
//  Created by Christopher Lee on 11/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation

public enum Result<T> {
    case Success(T)
    case Failure(Error)
}

enum NetworkJSONServiceError: Error {
    case NetworkingError(error: NSError)
    case NoData
}

enum ReponseData {
    case Response(data: Data)
}

protocol Gettable {
    associatedtype T
    func get(completionHandler: (Result<T>) -> Void)
}

protocol NetworkRequest: class {
    associatedtype T
    func load(withCompletion completion: @escaping (Result<T>) -> Void)
}

extension NetworkRequest {
    fileprivate func load(_ url: URL, withCompletion completion: @escaping (Result<T>) -> Void) {
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: url, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            
            if let error = error {
                completion(.Failure(error))
            }
            
            guard data != nil else {
                completion(.Failure(NetworkJSONServiceError.NoData))
                return
            }
            
            completion(.Success(ReponseData.Response(data: data!)))
        })
        task.resume()
    }
}

struct CoinService: Gettable {
    func get(completionHandler: (Result<Coin>) -> Void) {
        print("Stuff")
    }
}
