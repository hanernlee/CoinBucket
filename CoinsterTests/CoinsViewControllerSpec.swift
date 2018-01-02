//
//  CoinsViewControllerSpec.swift
//  CoinBucketTests
//
//  Created by Christopher Lee on 10/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation

import Foundation
import Quick
import Nimble

@testable import CoinBucket

class CoinsViewControllerSpec: QuickSpec {
    override func spec() {
        var subject: CoinsViewController!
        
        describe("CoinsViewController") {
            beforeEach {
                subject = CoinsViewController(collectionViewLayout: UICollectionViewFlowLayout())
                _ = subject.collectionView
            }
            
            context("when view is loaded") {
                it("should have fetched correct amount of coins") {
                    expect(subject.coins.count).toEventually(equal(10))
                }
            }
        }
    }
}
