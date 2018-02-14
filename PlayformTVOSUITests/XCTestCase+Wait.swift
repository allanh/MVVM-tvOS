//
//  XCTestCase+Wait.swift
//  PlayformTVOS
//
//  Created by allan.shih on 2017/8/8.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import XCTest

extension XCTestCase {
    // MARK: -
    
    /// Used to wait for time interval and help test asynchronous code.
    func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Waiting")
        
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        
        // We use a buffer here to avoid flakiness with Timer on CI
        waitForExpectations(timeout: duration + 0.5)
    }
}
