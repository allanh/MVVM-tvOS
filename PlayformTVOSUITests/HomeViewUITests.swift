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
 * HomeViewUITests.swift
 * PlayformTVOSTests
 *
 * Created by allan.shih on 2017/8/8.
 */

import XCTest

class HomeViewUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        // Entering debug model
        for _ in 0...6 {
            XCUIRemote.shared().press(.playPause)
        }
        
        // Waiting for the home view to appear
        wait(for: 1)
        XCUIRemote.shared().press(.menu)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testHomeView_whenEnterDebugMode_checkTabbarExist() {
        let app = XCUIApplication()
        let logoutButton = app.tabBars.buttons["Logout"]
        XCTAssertTrue(logoutButton.exists, "The 'Logout' button doesn't exist.")
        
        let settingsButton = app.tabBars.buttons["Settings"]
        XCTAssertTrue(settingsButton.exists, "The 'Settings' button doesn't exist.")
    }
    
    func testTapSettingsButton_whenDebugMode_doGoToSetting() {
        let app = XCUIApplication()
        let settingsButton = app.tabBars.buttons["Settings"]
        XCTAssertTrue(settingsButton.exists, "The 'Settings' button doesn't exist.")
        XCTAssertTrue(settingsButton.hasFocus, "The app should focus on the 'Settings' button")
        XCUIRemote.shared().press(.select)
        
        // Waiting for the home view to appear
        wait(for: 1)

        let accountCell = app.tables.cells.containing(.staticText, identifier:"john.smith2@mattel.com").element
        XCTAssertTrue(accountCell.exists, "The 'Your Account' cell doesn't exist.")
    }
    
    func testTapLogoutButton_whenDebugMode_doGoToLanding() {
        let app = XCUIApplication()
        let logoutButton = app.tabBars.buttons["Logout"]
        
        XCUIRemote.shared().press(.right)
        XCTAssertTrue(logoutButton.exists, "The 'Logout' button doesn't exist.")
        XCTAssertTrue(logoutButton.hasFocus, "The app should focus on the 'Logout' button")
        XCUIRemote.shared().press(.select)
        
        // Waiting for the home view to appear
        wait(for: 1)
        
        let withoutSignInButton = app.buttons["Play without Sign in"]
        XCTAssertTrue(withoutSignInButton.exists, "The 'Play without Sign in' button doesn't exist")
    }
}
