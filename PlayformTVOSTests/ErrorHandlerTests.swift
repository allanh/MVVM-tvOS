/*
 * Copyright (C) 2017 Mattel, Inc. All rights reserved.
 *
 * All information and code contained herein is the property of
 * Mattel, Inc.
 *
 * Any unauthorized use, storage, duplication, and redistribution of
 * this material without written permission from Mattel, Inc. is
 * strictly prohibited.
 *
 * ErrorHandlerTests.swift
 * PlayformTVOSTests
 *
 * Created by allan.shih on 2017/7/26.
 */

import XCTest
@testable import PlayformTVOS

class ErrorHandlerTests: XCTestCase {
    
    var errorhandler: ErrorHandler?
    
    override func setUp() {
        super.setUp()
        self.errorhandler = ErrorHandler()
    }
    
    override func tearDown() {
        self.errorhandler = nil
        super.tearDown()
    }
    
    func testCheckError_whenMissingParameter_callOtherHandler() {
        // 1. Arrange
        var isCalled = false
        let error = NSError(domain: "test",
                code: 99011,
                userInfo: [ NSLocalizedDescriptionKey : "test"])
        
        // 2. Act
        self.errorhandler?.checkError(error, handler: {(error) in
            isCalled = true
        })
        
        // 3. Assert
        XCTAssertTrue(isCalled, "The handler should be called.")
        
    }
}
