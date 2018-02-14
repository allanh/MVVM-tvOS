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
 * DateEnterPhase.swift
 * PlayformTVOSTests
 *
 * Created by sue.liu on 2017/7/31.
 */

import Foundation
import UIKit

protocol DateEnterPhase {
    var limitLength: Int { get }
    var exDate: Int { get }
    var inputEnd: Bool { get }
    var type: SettingConstant.DateType { get }
    var warnStr: String { get }
    func enterPhase()
    func nextPhase() -> DateEnterPhase
    func checkDateAvaliable(intYear: Int, intMonth: Int, intDay: Int, intNew: Int) -> DateCheckResult
}

extension DateEnterPhase
{
    func enterPhase() {}
    func nextPhase() -> DateEnterPhase { return YearPhase()}
    func checkDateAvaliable(intYear: Int, intMonth: Int, intDay: Int, intNew: Int) -> DateCheckResult {
        return DateCheckResult.Valid
    }
}

class YearPhase: DateEnterPhase {
    var limitLength: Int = 4
    var exDate: Int = 1984
    var inputEnd: Bool = false
    var type: SettingConstant.DateType = SettingConstant.DateType.YEAR
    var warnStr: String = NSLocalizedString("invalid_year", comment: "")
    func nextPhase () -> DateEnterPhase {
        return MonthPhase()
    }
    func enterPhase(){
        print("my phase: year")
    }
    func checkDateAvaliable(intYear: Int, intMonth: Int, intDay: Int, intNew: Int) -> DateCheckResult {
        return Date().checkDate(year: intNew)
    }
}
class MonthPhase: DateEnterPhase {
    var limitLength: Int = 2
    var exDate: Int = 12
    var inputEnd: Bool = false
    var type: SettingConstant.DateType = SettingConstant.DateType.MONTH
    var warnStr: String = NSLocalizedString("invalid_month", comment: "")
    func nextPhase () -> DateEnterPhase {
        return DayPhase()
    }
    func enterPhase(){
        print("my phase: month")
    }
    func checkDateAvaliable(intYear: Int, intMonth: Int, intDay: Int, intNew: Int) -> DateCheckResult {
        return Date().checkDate(year: intYear, month: intNew)
    }
}
class DayPhase: DateEnterPhase {
    var limitLength: Int = 2
    var exDate: Int = 28
    var inputEnd: Bool = true
    var type: SettingConstant.DateType = SettingConstant.DateType.DAY
    var warnStr: String = NSLocalizedString("invalid_date", comment: "")
    func enterPhase(){
        print("my phase: day")
    }
    func checkDateAvaliable(intYear: Int, intMonth: Int, intDay: Int, intNew: Int) -> DateCheckResult {
        return Date().checkDate(year: intYear, month: intMonth, day: intNew)
    }
}
