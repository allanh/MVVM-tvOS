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
 * Date+ComparetTests.swift
 * PlayformTVOSTests
 *
 * Created by allan.shih on 2017/7/31.
 */

import XCTest
@testable import PlayformTVOS

class Date_ComparetTests: XCTestCase {
    
    let calendar = Calendar.current
        
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetDaysInMonth_whenYearIsLeap_return29() {
        // 1. Arrange
        var days = 0
        var comp = DateComponents()
        comp.year = 2000
        comp.month = 2
        let date = calendar.date(from: comp)
        
        // 2. Act
        days = date?.getDaysInMonth() ?? 0
        
        // 3. Assert
        XCTAssertEqual(days, 29, "The days should be 29.")
    }
    
    func testGetDaysInMonth_whenYearNotLeap_return28() {
        // 1. Arrange
        var days = 0
        var comp = DateComponents()
        comp.year = 2001
        comp.month = 2
        let date = calendar.date(from: comp)
        
        // 2. Act
        days = date?.getDaysInMonth() ?? 0
        
        // 3. Assert
        XCTAssertEqual(days, 28, "The days should be 28.")
    }
    
    func testCheckDayInMonth_whenYearIsLeap_returnInValid() {
        // 1. Arrange
        var dateCheckResult = DateCheckResult.Valid
        var comp = DateComponents()
        comp.year = 2000
        comp.month = 2
        let date = calendar.date(from: comp)
        
        // 2. Act
        dateCheckResult = date?.checkDayInMonth(day: nil) ?? .Valid
        
        // 3. Assert
        XCTAssertEqual(dateCheckResult, .InValid, "The result should be InValid.")
    }
    
    func testCheckDayInMonth_whenYearIsLeap_returnValid() {
        // 1. Arrange
        var dateCheckResult = DateCheckResult.InValid
        var comp = DateComponents()
        comp.year = 2000
        comp.month = 2
        let date = calendar.date(from: comp)
        
        // 2. Act
        dateCheckResult = date?.checkDayInMonth(day: 29) ?? .InValid
        
        // 3. Assert
        XCTAssertEqual(dateCheckResult, .Valid, "The result should be Valid.")
    }
    
    func testIsValidMonth_whenMonthIsNil_returnFalse() {
        // 1. Arrange
        var dateCheckResult = DateCheckResult.Valid
        let date = Date()
        
        // 2. Act
        dateCheckResult = date.isValidMonth(nil)
        
        // 3. Assert
        XCTAssertEqual(dateCheckResult, .InValid, "The result should be InValid.")
    }
    
    func testIsValidMonth_whenMonthIsInValid_returnFalse() {
        // 1. Arrange
        var dateCheckResult = DateCheckResult.Valid
        let date = Date()
        
        // 2. Act
        dateCheckResult = date.isValidMonth(13)
        
        // 3. Assert
        XCTAssertEqual(dateCheckResult, .InValid, "The result should be InValid.")
    }
    
    func testIsValidMonth_whenMonthIsValid_returnTrue() {
        // 1. Arrange
        var dateCheckResult = DateCheckResult.InValid
        let date = Date()

        // 2. Act
        dateCheckResult = date.isValidMonth(12)
        
        // 3. Assert
        XCTAssertEqual(dateCheckResult, .Valid, "The result should be Valid.")
    }
    
    func testiIsValidYear_whenYearIsNil_returnFalse() {
        // 1. Arrange
        var dateCheckResult = DateCheckResult.Valid
        let date = Date()
        
        // 2. Act
        dateCheckResult = date.isValidYear(nil)
        
        // 3. Assert
        XCTAssertEqual(dateCheckResult, .InValid, "The result should be InValid.")
    }
    
    func testiIsValidYear_whenYearIsInValid_returnFalse() {
        // 1. Arrange
        var dateCheckResult = DateCheckResult.Valid
        let date = Date()
        
        // 2. Act
        dateCheckResult = date.isValidYear(2880)
        
        // 3. Assert
        XCTAssertEqual(dateCheckResult, .InValid, "The result should be InValid.")
    }
    
    func testIsValidYear_whenYearIsValid_returnTrue() {
        // 1. Arrange
        var dateCheckResult = DateCheckResult.InValid
        let date = Date()
        
        // 2. Act
        dateCheckResult = date.isValidYear(2016)
        
        // 3. Assert
        XCTAssertEqual(dateCheckResult, .Valid, "The result should be Valid.")
    }
    
    func testiIsValidYear_whenYearOfDateIsInValid_returnFalse() {
        // 1. Arrange
        var dateCheckResult = DateCheckResult.Valid
        var comp = DateComponents()
        comp.year = 1000
        let date = calendar.date(from: comp)
        
        // 2. Act
        dateCheckResult = date?.isValidYear() ?? .Valid
        
        // 3. Assert
        XCTAssertEqual(dateCheckResult, .InValid, "The result should be InValid.")
    }
    
    func testIsValidYear_whenYearOfDateIsValid_returnTrue() {
        // 1. Arrange
        var dateCheckResult = DateCheckResult.InValid
        var comp = DateComponents()
        comp.year = 2017
        let date = calendar.date(from: comp)
        
        // 2. Act
        dateCheckResult = date?.isValidYear() ?? .InValid
        
        // 3. Assert
        XCTAssertEqual(dateCheckResult, .Valid, "The result should be Valid.")
    }
}
