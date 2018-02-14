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
 * LandingViewUITests.swift
 * PlayformTVOSTests
 *
 * Created by allan.shih on 2017/8/7.
 */


import XCTest

class LandingViewUITests: XCTestCase {
        
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
    
    func testTapPlayWithoutSingInButton_withoutSigningIn_doGoToHome() {
        let app = XCUIApplication()
        let withoutSignInButton = app.buttons["Play without Sign in"]
        XCTAssertTrue(withoutSignInButton.exists, "The 'Play without Sign in' button doesn't exist")
        XCTAssertTrue(withoutSignInButton.hasFocus, "The app should focus on the 'Play without Sign in' button")
        XCUIRemote.shared().press(.select)
        
        // Waiting for the home view to appear
        wait(for: 1)
        XCUIRemote.shared().press(.menu)

        let loginButton = app.tabBars.buttons["Login"]
        XCTAssertTrue(loginButton.exists, "The 'Login' button doesn't exist")
    }
    
    func testTapLoginButton_withoutSigningIn_doGoToLanding() {
        let app = XCUIApplication()
        let withoutSignInButton = app.buttons["Play without Sign in"]
        XCTAssertTrue(withoutSignInButton.exists, "The 'Play without Sign in' button doesn't exist")
        XCTAssertTrue(withoutSignInButton.hasFocus, "The app should focus on the 'Play without Sign in' button")
        XCUIRemote.shared().press(.select)
        
        // Waiting for the home view to appear
        wait(for: 1)
        XCUIRemote.shared().press(.menu)
        XCTAssertFalse(withoutSignInButton.exists, "The 'Play without Sign in' button does exist")
        
        let loginButton = app.tabBars.buttons["Login"]
        XCTAssertTrue(loginButton.exists, "The 'Login' button doesn't exist.")
        XCTAssertTrue(loginButton.hasFocus, "The app should focus on the 'Login' button")
        XCUIRemote.shared().press(.select)
        
        // Waiting for the landing view to appear
        wait(for: 1)
        XCTAssertTrue(withoutSignInButton.exists, "The 'Play without Sign in' button doesn't exist")
    }
    
    func testTapSingInButton_withoutSigningIn_doGoToActivation() {
        let app = XCUIApplication()
        XCUIRemote.shared().press(.down)

        let signInWithPlayformButton = app.buttons["Sign in with Playform"]
        XCTAssertTrue(signInWithPlayformButton.exists, "The 'Sign in with Playform' button doesn't exist")
        XCTAssertTrue(signInWithPlayformButton.hasFocus, "The app should focus on the 'Sign in with Playform' button")
        XCUIRemote.shared().press(.select)
        
        // Waiting for the activation view to appear
        wait(for: 1)
        XCTAssertFalse(signInWithPlayformButton.exists, "The 'Sign in with Playform' button does exist")

        let getANewCodeButton = app.buttons["Get a New Code"]
        XCTAssertTrue(getANewCodeButton.exists, "The 'Get a New Code' button doesn't exist")
    }
    
}
