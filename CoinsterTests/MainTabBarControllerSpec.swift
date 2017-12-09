//
//  MainTabBarControllerSpec.swift
//  CoinsterTests
//
//  Created by Christopher Lee on 9/12/17.
//  Copyright © 2017 Christopher Lee. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Coinster

class MainTabBarControllerSpec: QuickSpec {
    override func spec() {
        var subject: MainTabBarController!
        
        describe("MainTabBarControllerSpec") {
            beforeEach {
                subject = MainTabBarController()
                _ = subject.view
            }
            
            context("when view is loaded") {
                it("should have setup tab bar items correctly") {
                    expect(subject.viewControllers?.count).to(equal(1))
                }
            }
        }
    }
}
