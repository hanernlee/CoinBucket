////
////  NetworkRequest.swift
////  Coinster
////
////  Created by Christopher Lee on 10/12/17.
////  Copyright © 2017 Christopher Lee. All rights reserved.
////
//
//import UIKit
//
//enum Result<T> {
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
//    func load(withCompletion completion: @escaping (Result<Model>?) -> Result<Model>)
//    func decode(_ data: Data) -> Model?
//}
//
//extension NetworkRequest {
//    fileprivate func load(_ url: URL, withCompletion completion: @escaping (Result<Model>?) -> Result<Model>) {
//        let configuration = URLSessionConfiguration.ephemeral
//        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
//        let task = session.dataTask(with: url, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
//
//            if let error = error {
//                completion(error)
//            }
//
//            guard let data = data else {
//
//            }
//
//            completion(.Success())
//        })
//        task.resume()
//    }
//}
//
//struct CoinService: NetworkRequest {
//    func load(_ url: URL, withCompletion completion: @escaping (Result<CoinService.Model>?) -> Void) {
//        <#code#>
//    }
//}

