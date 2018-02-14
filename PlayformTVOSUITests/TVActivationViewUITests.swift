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
 * TVActivationViewUITests.swift
 * PlayformTVOSTests
 *
 * Created by allan.shih on 2017/8/8.
 */

import XCTest

class TVActivationViewUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testTapMenuButton_withoutSigningIn_doGoToLanding() {
        let app = XCUIApplication()
        XCUIRemote.shared().press(.down)
        
        let signInWithPlayformButton = app.buttons["Sign in with Playform"]
        XCTAssert(signInWithPlayformButton.hasFocus, "The app should focus on the 'Sign in with Playform' button")
        XCUIRemote.shared().press(.select)
        
        // Waiting for the activation view to appear
        wait(for: 1)
        XCTAssertFalse(signInWithPlayformButton.exists, "The 'Sign in with Playform' button does exist")
        
        let getANewCodeButton = app.buttons["Get a New Code"]
        XCTAssertTrue(getANewCodeButton.exists, "The 'Get a New Code' button doesn't exist")
        XCUIRemote.shared().press(.menu)
        
        // Waiting for the landing view to appear
        wait(for: 1)
        XCTAssertTrue(signInWithPlayformButton.exists, "The 'Sign in with Playform' button doesn't exist")
    }
}
