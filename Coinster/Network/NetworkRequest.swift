////
////  NetworkRequest.swift
////  Coinster
////
////  Created by Christopher Lee on 11/12/17.
////  Copyright © 2017 Christopher Lee. All rights reserved.
////
//
//import Foundation
//
//public enum Result<T> {
//    case Success(T)
//    case Failure(Error)
//}
//
//enum NetworkJSONServiceError: Error {
//    case NetworkingError(error: NSError)
//    case NoData
//}
//
//protocol NetworkRequest: class {
//    associatedtype Model
//    func load(withCompletion completion: @escaping (Result<Model>) -> Void)
//}
//
//extension NetworkRequest {
//    fileprivate func loadRequest(_ url: URL, withCompletion completion: @escaping (Result<Any>) -> Void) {
//        let configuration = URLSessionConfiguration.ephemeral
//        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
//        let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
//            
//            if let error = error {
//                completion(.Failure(error))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.Failure(NetworkJSONServiceError.NoData))
//                return
//            }
//            
//            completion(.Success(data))
//        })
//        task.resume()
//    }
//}
//
//class CoinService: NetworkRequest {
//    var url: URL {
//        let baseUrl = "https://api.coinmarketcap.com/v1/ticker/"
//        let limit = "10"
//        let url = baseUrl + "?limit=" + limit
//        return URL(string: url)!
//    }
//
//    func load(withCompletion completion: @escaping (Result<Any>) -> Void) {
//        loadRequest(url, withCompletion: completion)
//    }
//}

