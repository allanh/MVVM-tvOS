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
 * Date+LeapYear.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/7/31.
 */

import Foundation

extension Date {
    /// Returns an indication whether the specified year is a leap year.
    ///
    /// - parameter year: year
    ///
    /// - returns: True if year is a leap year; otherwise, false.
    func isLeapYear(year: Int?) -> Bool {
        guard let year = year, year >= 4 else {
            return false
        }
        
        return year % 400 == 0 || (year % 100 != 0 && year % 4 == 0)
    }

    /// Returns an indication whether the specified date is a leap year.
    ///
    /// - parameter date: An optional NSDate value. If no date is provided, it defaults to today.    
    ///
    /// - returns: True if date is a leap year; otherwise, false.
    func isLeapYear() -> Bool {
        
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.year], from: self)
        
        let year = components.year
        return isLeapYear(year: year)
    }
}
