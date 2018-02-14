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
 * SettingConstant.swift
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/6/21.
 */

import Foundation

class SettingConstant {
    static let USER_PROFILE_VIEW_CONTROLLER  = "UserProfileViewController"
    static let CREATE_KID_PROFILE_VIEW_CONTROLLER  = "CreateKidViewController"
    static let KID_PROFILE_VIEW_CONTROLLER  = "KidProfileViewController"
    static let VERIFY_EMAIL_VIEW_CONTROLLER  = "VerifyEmailViewController"
    static let PRIVACY_VIEW_CONTROLLER  = "PrivacyStatementWebViewController"

    class Notification {
        static let CREATE_KID_SUCCESS  = "CreateKidSuccess"
        static let SHOW_CREATE_KID_INDICATOR  = "CreateKidIndicator"
        static let HIDE_CREATE_KID_INDICATOR  = "HideKidIndicator"
        static let UNABLE_TO_CONNECT_TO_SERVER = "UnableToConnectToServer"
        static let UNABLE_TO_ADD_KIDS = "UnableToAddKids"
        static let UNABLE_TO_UPDATE_INFORM = "UnableToUpdateInform"
        static let UPDATE_INFORM_SUCCESS = "UpdateInformSuccess"
        static let DISMISS_LOADING = "DismissLoading"
    }
    
    class DetailBlock {
        static let ADULT = "adult"
        static let KID = "kid"
    }
    
    enum Gender: String {
        case MALE = "MALE"
        case FEMALE = "FEMALE"
        case NONE = "None"
    }
    
    enum GenderOption: String {
        case MALE = "Male"
        case FEMALE = "Female"
    }

    enum KidGenderOption: String {
        case Boy = "Boy"
        case GIRL = "Girl"
    }
    
    enum DataField: String {
        case FirstName = "firstname"
        case LastName = "lastname"
        case Gender = "gender"
        case Birth = "birth"
        case NickName = "nickname"
    }
    
    enum DateType: Int {
        case YEAR = 0
        case MONTH = 1
        case DAY = 2
        case END = 3

        var description : String {
            switch self {
                case .YEAR: return "Year"
                case .MONTH: return "Month"
                case .DAY: return "Day"
                case .END: return ""
            }
        }
    }
}

