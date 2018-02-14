//
//  Config.swift
//  PlayformTVOS
//
//  Created by allan.shih on 2017/7/11.
//  Copyright © 2017年 allan.shih. All rights reserved.
//

import Foundation

/// Server Environment Types
enum EnvironmentType: String {
    /**
     For mobile app team development and internal QA test
     - Build number: `00`
     - Swift compiler flag: `QA`
     */
    case qa = "qa"
    /**
     QA tested, for official business showcase and demo
     - Build number: `01`
     - Swift compiler flag: `STAGING`
     */
    case staging = "staging"
    /**
     The mirror of production for deploy test
     - Build number: `02`
     - Swift compiler flag: `PrePROD`
     */
    case preProduction = "preProduction"
    /**
     Release
     - Build number: `03`
     - Swift compiler flag: `PROD`
     */
    case production = "production"
}

/// This class contains 'Aristotle' configuration
class Config {
    
    // MARK: - Environment
    #if QA
    static let ENVIRONMENT:EnvironmentType = .qa
    #elseif STAGING
    static let ENVIRONMENT:EnvironmentType = .staging
    #elseif PrePROD
    static let ENVIRONMENT:EnvironmentType = .preProduction
    #elseif PROD
    static let ENVIRONMENT:EnvironmentType = .production
    #else
    /// - Warning: You did not define server environment in swift compiler flag. Defaults to .staging
    static let ENVIRONMENT:EnvironmentType = .staging
    #endif
    
}
