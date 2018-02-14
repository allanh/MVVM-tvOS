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
 * Logger.swift
 * PlayformTVOS
 *
 * Created by 戴鵬洋 on 2017/6/22.
 */


import Foundation
import os

// MARK: Mock Swift module

/**
 Log message into _Apple System Logger_ when `PROD` is **not** defined in swift compmiler.
 
 - Parameters:
     - items: Zero or more items to print.
     - separator: A string to print between each item. The default is a single space (`" "`).
     - terminator: The string to print after all items have been printed. The default is a newline (`"\n"`).
 
 - Warning: Your call is redirected to `os.os_log()` or `Foundation.NSLog()` depending on availability in order to log into _Apple System Logger_.
 - SeeAlso: `debugPrint(_:separator:terminator:)`, `TextOutputStreamable`, `CustomStringConvertible`, `CustomDebugStringConvertible`
 */
public func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    guard shouldPrintInCurrnetEnvironment(in: .showOtherThanProduction) else { return }
    print(items: items, separator: separator, terminator: terminator)
}

/**
 Log message into _Apple System Logger_ when `PROD` is **not** defined in swift compmiler.
 
 - Parameters:
     - items: Zero or more items to print.
     - separator: A string to print between each item. The default is a single space (`" "`).
     - terminator: The string to print after all items have been printed. The default is a newline (`"\n"`).
 
 - Warning: Your call is redirected to `os.os_log()` or `Foundation.NSLog()` depending on availability in order to log into _Apple System Logger_.
 - SeeAlso: `print(_:separator:terminator:)`, `TextOutputStreamable`, `CustomStringConvertible`, `CustomDebugStringConvertible`
 */
public func debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    guard shouldPrintInCurrnetEnvironment(in: .showOtherThanProduction) else { return }
    print(items: items, separator: separator, terminator: terminator)
}

// MARK: Print with environment

/// Levels are coupled with server environment declared in `Config.ENVIRONMENT`.
public enum LogLevel {
    /// Log in all server environment **even if in Production**. Use under performance consideration.
    case showInProduction
    
    /// Log in environments other than PROD
    case showOtherThanProduction
}

private func shouldPrintInCurrnetEnvironment(in level: LogLevel) -> Bool {
    switch Config.ENVIRONMENT {
    case .qa, .staging, .preProduction:
        return true
    case .production:
        return level == .showInProduction
    }
}

/**
 Log message into _Apple System Logger_ with level.
 
 - Parameters:
    - items: Zero or more items to print.
    - separator: A string to print between each item. The default is a single space (`" "`).
    - terminator: The string to print after all items have been printed. The default is a newline (`"\n"`).
    - level: See more in `enum LogLevel`
 
 - SeeAlso: `LogLevel`, `print(_:separator:terminator:)`, `TextOutputStreamable`, `CustomStringConvertible`, `CustomDebugStringConvertible`
 */
public func print(_ items: Any..., separator: String = " ", terminator: String = "\n", level: LogLevel) {
    guard shouldPrintInCurrnetEnvironment(in: level) else { return }
    print(items: items, separator: separator, terminator: terminator)
}

// MARK: Formatter

/// Composite print string and log with API availability.
private func print(items: [Any], separator: String, terminator: String) {
	/// As `Swift.print()` takes parameters different from CVarArg of `Foundation.NSLog()` and `os.os_log`, need to combines output string with our own.
	let description = items
		.reduce("") { $0.appending("\($1)" + separator) }
		.appending(terminator)
    
    if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) {
		os_log("%{public}@", description)
	} else {
		NSLog("%@", description)
	}
}
