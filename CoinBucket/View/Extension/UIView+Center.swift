//
//  UIView+Center.swift
//  CoinBucket
//
//  Created by Christopher Lee on 30/9/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import UIKit

extension UIView {
    public func centerPoint() -> CGPoint {
        guard let center = UIApplication.shared.keyWindow?.center else {
            return CGPoint(x: 0, y: 0)
        }
        return center
    }
}
