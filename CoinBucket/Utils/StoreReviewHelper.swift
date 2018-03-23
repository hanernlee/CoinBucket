//
//  StoreReviewHelper.swift
//  CoinBucket
//
//  Created by Christopher Lee on 23/3/18.
//  Copyright © 2018 Christopher Lee. All rights reserved.
//

import Foundation
import StoreKit

struct StoreReviewHelper {
    static func incrementAppOpenedCount() { // called from appdelegate didfinishLaunchingWithOptions:
        guard var appOpenCount = UserDefaults.standard.value(forKey: "openCount") as? Int else {
            UserDefaults.standard.set(1, forKey: "openCount")
            return
        }
        appOpenCount += 1

        userDefaults.set(appOpenCount, forKey: "openCount")
    }
    static func checkAndAskForReview() { // call this whenever appropriate
        // this will not be shown everytime. Apple has some internal logic on how to show this.
        guard let appOpenCount = UserDefaults.standard.value(forKey: "openCount") as? Int else {
            UserDefaults.standard.set(1, forKey: "openCount")
            return
        }
        
        switch appOpenCount {
        case 10,50:
            StoreReviewHelper().requestReview()
        case _ where appOpenCount%100 == 0 :
            StoreReviewHelper().requestReview()
        default:
            print("App run count is : \(appOpenCount)")
            break;
        }
        
    }
    fileprivate func requestReview() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        }
    }
}
