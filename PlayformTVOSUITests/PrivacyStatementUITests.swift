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
 * PrivacyStatementUITests.swift
 * PlayformTVOSTests
 *
 * Created by allan.shih on 2017/8/8.
 */

import XCTest

class PrivacyStatementUITests: XCTestCase {
    
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
        
        // Waiting for the Settings view to appear
        XCUIRemote.shared().press(.select)
        wait(for: 1)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTapPrivacyStatement_whenDebugMode_doGoToPrivacyStatement() {
        let app = XCUIApplication()
        let privacyStatementCell = app.tables.cells.containing(.staticText, identifier:"Privacy Statement").element
        XCTAssertTrue(privacyStatementCell.exists, "The Privacy Statement cell doesn't exist.")
        
        for _ in 0...5 {
            XCUIRemote.shared().press(.down)
        }

        XCTAssertTrue(privacyStatementCell.hasFocus, "The app should focus on the Privacy Statement cell")
        XCUIRemote.shared().press(.select)
        
        // Waiting for the home view to appear
        wait(for: 1)
        let textView = XCUIApplication().windows.children(matching: .other).element(boundBy: 2)
            .children(matching: .other).element.children(matching: .textView).element
        XCTAssertTrue(textView.exists, "The Privacy Statement TextView doesn't exist.")
        XCTAssertTrue(textView.hasFocus, "The app should focus on the Privacy Statement TextView")
    }
    
    func testTapMenu_whenDebugMode_doGoToSettings() {
        let app = XCUIApplication()
        let privacyStatementCell = app.tables.cells.containing(.staticText, identifier:"Privacy Statement").element
        XCTAssertTrue(privacyStatementCell.exists, "The Privacy Statement cell doesn't exist.")
        
        for _ in 0...5 {
            XCUIRemote.shared().press(.down)
        }
        
        XCTAssertTrue(privacyStatementCell.hasFocus, "The app should focus on the Privacy Statement cell")
        XCUIRemote.shared().press(.select)
        
        // Waiting for the home view to appear
        wait(for: 1)
        XCTAssertFalse(privacyStatementCell.exists, "The Privacy Statement cell does exist.")

        let textView = XCUIApplication().windows.children(matching: .other).element(boundBy: 2)
            .children(matching: .other).element.children(matching: .textView).element
        XCTAssertTrue(textView.exists, "The Privacy Statement TextView doesn't exist.")
        XCTAssertTrue(textView.hasFocus, "The app should focus on the Privacy Statement TextView")
        XCUIRemote.shared().press(.menu)
        
        // Waiting for the Settings view to appear
        wait(for: 1)
        XCTAssertTrue(privacyStatementCell.exists, "The Privacy Statement cell doesn't exist.")
    }
}
