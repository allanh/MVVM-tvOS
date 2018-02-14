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
 * SettingsViewModelWithFakeDataTests.swift
 * PlayformTVOSTests
 *
 * Created by allan.shih on 2017/6/26.
 */

import XCTest
@testable import PlayformTVOS

class SettingsViewModelWithFakeDataTests: XCTestCase {
    
    var viewModel: SettingsViewModel?

    override func setUp() {
        super.setUp()
        self.viewModel = SettingsViewModel(userProfile: nil, kidAccounts: nil, settingsCallback: nil)
    }
    
    override func tearDown() {
        self.viewModel = nil
        super.tearDown()
    }

    // MARK: - Fake Data Tests
    
    func testStatus_afterInitialized_returnNotNil() {
        // Assert
        XCTAssertNotNil(self.viewModel, "The view model shoudldn't be nil.")
        XCTAssertTrue(self.viewModel?.isFakeData ?? false, "The isFakeData shoudld be true.")
    }
    
    func testGetFirstName_useFakeDate_returnAllan() {
        // Assert
        XCTAssertNotNil(self.viewModel?.getUserProfile()?.firstName, "The first name shoudldn't be nil.")
        XCTAssertEqual(self.viewModel?.getUserProfile()?.firstName, "Allan", "The first name should be Allan")
    }
    
    func testGetMonthOfBirth_useFakeDate_return6() {
        // Assert
        XCTAssertNotNil(self.viewModel?.getUserProfile()?.monthOfBirth, "The monthOfBirth shoudldn't be nil.")
        XCTAssertEqual(self.viewModel?.getUserProfile()?.monthOfBirth, 6, "The month of birth should be 6")
    }
    
    func testGetUserEmail_useFakeData_returnJohnSmith() {
        // Assert
        XCTAssertNotNil(self.viewModel?.getUserProfile()?.primaryEmail?.email, "The email shouldn't nil")
        XCTAssertEqual(self.viewModel?.getUserProfile()?.primaryEmail?.email, "john.smith2@mattel.com", "The user email should be john.smith2@mattel.com")
    }
    
    func testGetKidAccounts_useFakeData_returnSelena() {
        // 1. Arrange
        var kidsAccounts: [KidAccountPresentable]? = nil
        
        // 2. Act
        kidsAccounts = self.viewModel?.getKidsAccounts()
        
        // 3. Assert
        XCTAssertNotNil(kidsAccounts, "The kids accounts shouldn't nil.")
        XCTAssertEqual(kidsAccounts?.count, 3, "The kids accounts count should be 3")
        XCTAssertEqual(kidsAccounts?[0].kidNickName, "Selena", "The kid nickname should be Selena.")
    }
}
