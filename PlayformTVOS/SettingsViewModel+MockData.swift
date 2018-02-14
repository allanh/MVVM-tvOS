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
 * SettingsViewModel+MockData.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/6/23.
 */

import Foundation
import PlayformSDK_TV

// MARK: - Mock datas

extension SettingsViewModel {
    
    var mockUserProfile: UserProfile {
        let userProfile = UserProfile()
        userProfile.firstName = "Allan"
        userProfile.lastName = "Lee"
        userProfile.gender = "MALE"
        userProfile.dayOfBirth = 8
        userProfile.monthOfBirth = 6
        userProfile.yearOfBirth = 1980
        userProfile.addresses = [self.mockUserProfileAddress]
        userProfile.emails = [self.mockUserProfileEmail]
        return userProfile
    }
    
    var mockUserProfileAddress: UserProfileAddress {
        let userProfileAddress = UserProfileAddress()
        userProfileAddress.addressType = "BILLING"
        userProfileAddress.firstAddressLine = "69 Parisian Spur Suite 758"
        userProfileAddress.secondAddressLine = "Apt. 456"
        userProfileAddress.city = "Pueblo"
        userProfileAddress.state = "CO, Colorado"
        userProfileAddress.zipCode = "21854-1559"
        userProfileAddress.country = "United States"
        userProfileAddress.isPrimary = true
        return userProfileAddress
    }
    
    var mockUserProfileEmail: UserProfileEmail {
        let userProfileEmail = UserProfileEmail()
        userProfileEmail.emailType = "PERSONAL"
        userProfileEmail.email = "john.smith2@mattel.com"
        userProfileEmail.isPrimary = true
        userProfileEmail.verified = true
        return userProfileEmail
    }
    
    var mockKidsAccounts: [KidAccount]? {
        var kidsAccounts = [KidAccount]()
        let nickNames = ["Selena", "Kate", "Johnny"]
        let genders = ["FEMALE", "FEMALE", "MALE"]
        
        for index in 0...2 {
            let kidProfile = KidProfile()
            kidProfile.nickName = nickNames[index]
            kidProfile.gender = genders[index]
            kidProfile.yearOfBirth = 1988
            kidProfile.monthOfBirth = 12
            kidProfile.dayOfBirth = 6 + index
            
            let kidAccount = KidAccount()
            kidAccount.kidProfile = kidProfile
            kidsAccounts.append(kidAccount)
        }
        
        return kidsAccounts
    }
}
