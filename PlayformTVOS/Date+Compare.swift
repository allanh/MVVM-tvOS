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
 * Date+Compare
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/7/12.
 */
import Foundation

enum DateCheckResult {
    case Valid
    case LaterThanToday
    case InValid
    
    var warn: String {
        switch self {
        case .LaterThanToday:
            return "date_later_than_today"
        default:
            return ""
        }
    }
}

extension Date {
    
    func checkDate(year: Int) -> DateCheckResult {
        if (isValidYear(year) == .InValid) {
            return .InValid
        } else {
            if (compareDateEarlyOrNot(year: year) == .Valid) {
                return .Valid
            } else {
                return .LaterThanToday
            }
        }
    }
    
    func checkDate(year: Int, month: Int) -> DateCheckResult {
        if (isValidMonth(month) == .InValid) {
            return .InValid
        } else {
            if (compareDateEarlyOrNot(year: year, month: month) == .Valid) {
                return .Valid
            } else {
                return .LaterThanToday
            }
        }
    }
    
    func checkDate(year: Int, month: Int, day: Int) -> DateCheckResult {
        if (isValidDay(year: year, month: month, day: day) == .InValid) {
            return .InValid
        } else {
            if (compareDateEarlyOrNot(year: year, month: month, day: day) == .Valid) {
                return .Valid
            } else {
                return .LaterThanToday
            }
        }
    }
    func compareDateEarlyOrNot(year: Int = 1980, month: Int = 1, day: Int = 1) -> DateCheckResult {
        // Specify date components
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = TimeZone.current
            
        // Create date from components
        let userCalendar = Calendar.current // user calendar
        if let inputDateTime = userCalendar.date(from: dateComponents) {
            //compare
            if(inputDateTime < self) {
                return .Valid
            }
        }
        return .LaterThanToday
    }
    
    /// Return the number of days in the date's month.
    ///
    /// - returns: The number of days, default 0.
    func getDaysInMonth() -> Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: self)
        let numDays = range?.count
        
        return numDays ?? 0
    }
    
    func isValidDay(year: Int, month: Int, day: Int) -> DateCheckResult {
        
        guard day != 0 else {
            return .InValid
        }
        
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents) ?? Date()
        if let range = calendar.range(of: .day, in: .month, for: date) {
            if (day <= range.count) {
                return .Valid
            }
        }
        return .InValid
    }
    
    /// Determine if the day in the date's month.
    ///
    /// - returns: Valid if the day in the date's month; otherwise, InValid.
    func checkDayInMonth(day: Int?) -> DateCheckResult {
        guard let day = day else {
            return .InValid
        }
        
        if day > 0 && self.getDaysInMonth() > 0 && day <= self.getDaysInMonth() {
            return .Valid
        } else {
            return .InValid
        }
    }
    
    /// Determine if the month is between 1 to 12.
    ///
    /// - returns: Valid if the month is between 1 to 12; otherwise, InValid.
    func isValidMonth(_ month: Int?) -> DateCheckResult {
        guard let month = month else {
            return .InValid
        }
        
        if month > 0 && month < 13 {
            return .Valid
        } else {
            return .InValid
        }
    }
    
    /// Determine if the year is are between 1981 to this year
    ///
    /// - returns: Valid if the year is valid; otherwise, InValid.
    func isValidYear(_ year: Int?) -> DateCheckResult {
        // Current date
        let calendar = Calendar.current
        let currentComp = calendar.dateComponents([.year], from: Date())
        let currentYear = currentComp.year ?? 0
        
        if let year = year, year >= 1910,
            currentYear > 0, year <= currentYear {
            return .Valid
        } else {
            return .InValid
        }
    }
    
    /// Determine if the year is are between 1981 to this year
    ///
    /// - parameter year: year
    ///
    /// - returns: Valid if the year is valid; otherwise, InValid.
    func isValidYear() -> DateCheckResult {
        // Current date
        let calendar = Calendar.current
        let year = calendar.dateComponents([.year], from: self).year
        return self.isValidYear(year)
    }
}
