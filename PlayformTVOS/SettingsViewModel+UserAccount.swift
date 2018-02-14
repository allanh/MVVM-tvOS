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
 * SettingsViewModel+UserAccount.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/6/22.
 */

import Foundation
import PlayformSDK_TV

extension SettingsViewModel {
    func setUserProfile(_ userProfile: UserProfile?) {
        self.userProfile = userProfile
    }
    
    func getUserProfile() -> UserProfilePresentable? {
        var userProfilePresentable: UserProfilePresentable?
        if let profile = self.isFakeData ? self.mockUserProfile : self.userProfile {
            userProfilePresentable = MyUserProfile(userProfile: profile)
        }
        return userProfilePresentable
    }
}
