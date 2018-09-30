//
//  Storyboardable.swift
//  CoinBucket
//
//  Created by Christopher Lee on 1/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

public protocol Storyboardable {
    static var storyboardName: String { get }
    static func instantiateFromStoryboard() -> Self
}

public extension Storyboardable {
    public static var storyboardName: String {
        return String(describing: self)
    }
    
    public static func instantiateFromStoryboard() -> Self {
        return instantiateFromStoryboard(name: storyboardName)
    }
    
    public static func instantiateFromStoryboard(name: String) -> Self {
        return UIStoryboard(name: name, bundle: Bundle(for: Self.self as! AnyClass)).instantiateInitialViewController() as! Self
    }
}
