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
 * Date+LeapYearTests.swift
 * PlayformTVOSTests
 *
 * Created by allan.shih on 2017/7/31.
 */

import XCTest
@testable import PlayformTVOS

class Date_LeapYearTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testIsLeapYear_whenYearIsNil_returnFalse() {
        // 1. Arrange
        var isLeapYear = true
        let date = Date()
        
        // 2. Act
        isLeapYear = date.isLeapYear(year: nil)
        
        // 3. Assert
        XCTAssertFalse(isLeapYear, "The isLeapYear flag should be false.")
    }
    
    func testIsLeapYear_whenYearIsLeap_returnTrue() {
        // 1. Arrange
        var isLeapYear = false
        let date = Date()
        
        // 2. Act
        isLeapYear = date.isLeapYear(year: 2000)
        XCTAssertTrue(isLeapYear, "The isLeapYear flag should be true.")
        isLeapYear = date.isLeapYear(year: 2016)

        // 3. Assert
        XCTAssertTrue(isLeapYear, "The isLeapYear flag should be true.")
    }
    
    func testIsLeapYear_whenYearIsNotLeap_returnFalse() {
        // 1. Arrange
        var isLeapYear = true
        let date = Date()
        
        // 2. Act
        isLeapYear = date.isLeapYear(year: 1900)
        XCTAssertFalse(isLeapYear, "The isLeapYear flag should be false.")
        isLeapYear = date.isLeapYear(year: 2015)
        
        // 3. Assert
        XCTAssertFalse(isLeapYear, "The isLeapYear flag should be false.")
    }
    
    func testIsLeapYear_whenDateIsLeap_returnTrue() {
        // 1. Arrange
        var isLeapYear = false
        let calendar = NSCalendar.current
        var comp = calendar.dateComponents([.year], from: Date())
        comp.year = 2000
        let date = calendar.date(from: comp)
        
        // 2. Act
        isLeapYear = date?.isLeapYear() ?? false
        
        // 3. Assert
        XCTAssertTrue(isLeapYear, "The isLeapYear flag should be true.")
    }
    
    func testIsLeapYear_whenDateIsNotLeap_returnTrue() {
        // 1. Arrange
        var isLeapYear = true
        let calendar = NSCalendar.current
        var comp = calendar.dateComponents([.year], from: Date())
        comp.year = 2015
        let date = calendar.date(from: comp)
        
        // 2. Act
        isLeapYear = date?.isLeapYear() ?? true
        
        // 3. Assert
        XCTAssertFalse(isLeapYear, "The isLeapYear flag should be false.")
    }
}
