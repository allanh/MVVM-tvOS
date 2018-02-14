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
 * KidAccountPresentable.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/6/22.
 */

import Foundation
import PlayformSDK_TV

// MARK: - Kid Account
/// This class contains the child profile (KidProfile).
protocol KidAccountPresentable {
    var kidAccount: KidAccount? { get set }
    /// Nickname
    var kidNickName: String? { get set }
    
    /// Gender
    var kidGender: String? { get set }
    
    /// Birth Year
    var kidYearOfBirth: Int? { get set }
    
    /// Birth Month
    var kidMonthOfBirth: Int? { get set }
    
    /// Birth Day
    var kidDayOfBirth: Int? { get set }
    
    /// Avatar (URL)
    var kidAvatarUrl: String? { get set }
    
    // MARK: - initializers
    
    init(kidAccount: KidAccount?)
    
    // MARK: - Methods
    
    func createKidAccount(onSuccess:@escaping (_ kidAccount: KidAccount)->(), onError:@escaping (_ error: Error)->())
    func updateKidAccount(onSuccess:@escaping (_ kidAccount: KidAccount)->(), onError:@escaping (_ error: Error)->())
    func deleteKidAccount(onSuccess:@escaping ()->(), onError:@escaping (_ error: Error)->())
}

// MARK: - Default Methods

extension KidAccountPresentable {
    
    func createKidAccount(onSuccess:@escaping (_ kidAccount:KidAccount)->(), onError:@escaping (_ error: Error)->()) {
        guard let kidProfile = self.kidAccount?.kidProfile else {
            print("no kidprofile")
            return
        }
        print(kidProfile.toJSON())
        SettingsManager.shared.createKidAccount(kidProfile: kidProfile, onSuccess: onSuccess, onError: onError)
    }
    
    func updateKidAccount(onSuccess:@escaping (_ kidAccount:KidAccount)->(), onError:@escaping (_ error: Error)->()) {
        guard let kidAccount = self.kidAccount else {
            print("no kidprofile")
            return
        }
        SettingsManager.shared.updateKidAccount(kidAccount: kidAccount, onSuccess: onSuccess, onError: onError)
    }
    
    func deleteKidAccount(onSuccess:@escaping ()->(), onError:@escaping (_ error: Error)->()) {
        guard let kidAccount = self.kidAccount else {
            print("no kidprofile")
            return
        }
        SettingsManager.shared.deleteKidAccount(kidAccount: kidAccount, onSuccess: onSuccess, onError: onError)
    }
}

// MARK: - Cusomize KidAccount

struct MyKidAccount: KidAccountPresentable {
    var kidAccount: KidAccount?
    
    /// Nickname
    var kidNickName: String? {
        get {
            return self.kidAccount?.kidProfile?.nickName
        }
        set {
            self.kidAccount?.kidProfile?.nickName = newValue
        }
    }
    /// Gender
    var kidGender: String? {
        get {
            return self.kidAccount?.kidProfile?.gender
        }
        set {
            self.kidAccount?.kidProfile?.gender = newValue
        }
    }
    
    /// Birth Year
    var kidYearOfBirth: Int? {
        get {
            return self.kidAccount?.kidProfile?.yearOfBirth
        }
        set {
            self.kidAccount?.kidProfile?.yearOfBirth = newValue
        }
    }
    
    /// Birth Month
    var kidMonthOfBirth: Int? {
        get {
            return self.kidAccount?.kidProfile?.monthOfBirth
        }
        set {
            self.kidAccount?.kidProfile?.monthOfBirth = newValue
        }
    }
    
    /// Birth Day
    var kidDayOfBirth: Int? {
        get {
            return self.kidAccount?.kidProfile?.dayOfBirth
        }
        set {
            self.kidAccount?.kidProfile?.dayOfBirth = newValue
        }
    }
    
    /// Avatar (URL)
    var kidAvatarUrl: String? {
        get {
            return self.kidAccount?.kidProfile?.avatarUrl
        }
        set {
            self.kidAccount?.kidProfile?.avatarUrl = newValue
        }
    }
    
    // MARK: - initializers

    init(kidAccount: KidAccount?) {
        if kidAccount != nil {
            self.kidAccount = kidAccount
        } else {
            self.kidAccount = KidAccount()
        }
        
        if self.kidAccount?.kidProfile == nil {
           self.kidAccount?.kidProfile = KidProfile()
        }
    }
}
