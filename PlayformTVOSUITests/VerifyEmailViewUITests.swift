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
 * VerifyEmailViewUITests.swift
 * PlayformTVOSTests
 *
 * Created by allan.shih on 2017/8/8.
 */

import XCTest

class VerifyEmailViewUITests: XCTestCase {
    
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
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    func testTapPrivacyStatement_whenDebugMode_doGoToPrivacyStatement() {
        let app = XCUIApplication()
        let emailVerificationCell = app.tables.cells.containing(.staticText, identifier:"Email Verification").element
        XCTAssertTrue(emailVerificationCell.exists, "The Email Verification cell doesn't exist.")
        
        for _ in 0...4 {
            XCUIRemote.shared().press(.down)
        }
        
        XCTAssertTrue(emailVerificationCell.hasFocus, "The app should focus on the Email Verification cell")
        XCUIRemote.shared().press(.select)
        
        // Waiting for the home view to appear
        wait(for: 1)
        let okButton = XCUIApplication().buttons["OK"]
        XCTAssertTrue(okButton.exists, "The ok button doesn't exist.")
        XCTAssertTrue(okButton.hasFocus, "The app should focus on the ok button")
    }
    
    func testTapOkButton_whenDebugMode_doGoToSettings() {
        let app = XCUIApplication()
        let emailVerificationCell = app.tables.cells.containing(.staticText, identifier:"Email Verification").element
        XCTAssertTrue(emailVerificationCell.exists, "The Email Verification cell doesn't exist.")
        
        for _ in 0...4 {
            XCUIRemote.shared().press(.down)
        }
        
        XCTAssertTrue(emailVerificationCell.hasFocus, "The app should focus on the Email Verification cell")
        XCUIRemote.shared().press(.select)
        
        // Waiting for the home view to appear
        wait(for: 1)
        XCTAssertFalse(emailVerificationCell.exists, "The Email Verification cell does exist.")
        
        let okButton = XCUIApplication().buttons["OK"]
        XCTAssertTrue(okButton.exists, "The ok button doesn't exist.")
        XCTAssertTrue(okButton.hasFocus, "The app should focus on the ok button")
        XCUIRemote.shared().press(.select)
        
        // Waiting for the Settings view to appear
        wait(for: 1)
        XCTAssertTrue(emailVerificationCell.exists, "The Email Verification cell doesn't exist.")
    }
    
    func testTapResendButton_whenDebugMode_doNothing() {
        let app = XCUIApplication()
        let emailVerificationCell = app.tables.cells.containing(.staticText, identifier:"Email Verification").element
        XCTAssertTrue(emailVerificationCell.exists, "The Email Verification cell doesn't exist.")
        
        for _ in 0...4 {
            XCUIRemote.shared().press(.down)
        }
        
        XCTAssertTrue(emailVerificationCell.hasFocus, "The app should focus on the Email Verification cell")
        XCUIRemote.shared().press(.select)
        
        // Waiting for the home view to appear
        wait(for: 1)
        XCTAssertFalse(emailVerificationCell.exists, "The Email Verification cell does exist.")
        
        let resendButton = XCUIApplication().buttons["Resend"]
        XCTAssertTrue(resendButton.exists, "The Resend button doesn't exist.")
        
        XCUIRemote.shared().press(.down)
        XCTAssertTrue(resendButton.hasFocus, "The app should focus on the Resend button")
        XCUIRemote.shared().press(.select)
        
        // Waiting for the Settings view to appear
        wait(for: 1)
        XCTAssertFalse(emailVerificationCell.exists, "The Email Verification cell does exist.")
    }
}
