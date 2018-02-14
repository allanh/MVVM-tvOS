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
 * SettingsManager.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/6/26.
 */

import Foundation
import PlayformSDK_TV

protocol SettingsManagerDelegate: class {
    func didReceiveUserProfile(_ userProfile: UserProfile)
    func didReceiveKidAccounts(_ kidAccounts: [KidAccount])
}

class SettingsManager {
    static let shared = SettingsManager()
    
    // Interal Properties

    var userProfile: UserProfile? {
        didSet {
            if let newUserProfile = self.userProfile {
                self.delegate?.didReceiveUserProfile(newUserProfile)
            }
        }
    }
    
    var kidAccounts: [KidAccount]? {
        didSet {
            if let newKidAccounts = self.kidAccounts {
                self.delegate?.didReceiveKidAccounts(newKidAccounts)
            }
        }
    }
    
    weak var delegate: SettingsManagerDelegate?    
    
    // MARK: - initializers

    init() {}
    
    /// This function can be used to fetch user profiles via UserManager.
    func syncUserProfile() {
        UserManager.getUserProfile(onSuccess: { (userProfile) in
            print("Get the user profile")
            print("NickName: \(userProfile.nickName ?? "")")
            self.userProfile = userProfile
            self.syncKidAccounts()
        }) { (error) in
            print(error.localizedDescription, level: .showInProduction)
            ErrorHandler.shared.checkError(error, handler: nil)
        }
    }
    
    func syncKidAccounts() {
        UserManager.getKidAccountList(onSuccess: { (kidAccounts) in
            print("Get the kidAccounts")
            self.kidAccounts = kidAccounts
        }) { (error) in
            print(error.localizedDescription, level: .showInProduction)
            ErrorHandler.shared.checkError(error, handler: nil)
        }
    }
    
    func createKidAccount(kidProfile: KidProfile,
                          onSuccess:@escaping (_ kidAccount: KidAccount)->(),
                          onError:@escaping (_ error: Error)->()) {
        
        UserManager.createKidAccount(kidProfile: kidProfile, onSuccess: { (kidAccount) in
            // Updating the kid accounts.
            if self.getKidAccountIndex(kidAccount: kidAccount) < 0 {
                self.kidAccounts?.append(kidAccount)
            }
            onSuccess(kidAccount)
        }) { (error) in
            print("[SettingsManager] \(error.localizedDescription)", level: .showInProduction)
//            NotificationCenter.default.post(
//                name: NSNotification.Name(rawValue: SettingConstant.Notification.DISMISS_LOADING),
//                object: nil
//            )
            ErrorHandler.shared.checkError(error, handler: onError)
        }
    }
    
    func updateKidAccount(kidAccount: KidAccount,
                          onSuccess:@escaping (_ kidAccount: KidAccount)->(),
                          onError:@escaping (_ error: Error)->()) {
        
        UserManager.updateKidProfile(kidAccount: kidAccount, onSuccess: { (kidAccount) in
            // Updating the kid accounts.
            let index = self.getKidAccountIndex(kidAccount: kidAccount)
            if index >= 0 {
                self.kidAccounts?[index] = kidAccount
            }
            onSuccess(kidAccount)
        }) { (error) in
            print(error.localizedDescription, level: .showInProduction)
            ErrorHandler.shared.checkError(error, handler: onError)
        }
    }
    
    func deleteKidAccount(kidAccount: KidAccount,
                          onSuccess:@escaping ()->(),
                          onError:@escaping (_ error: Error)->()) {
        
        UserManager.deleteKidAccount(kidAccount: kidAccount, onSuccess: { () in
            // Updating the kid accounts.
            let index = self.getKidAccountIndex(kidAccount: kidAccount)
            if index >= 0 {
                self.kidAccounts?.remove(at: index)
            }
            onSuccess()
        }) { (error) in
            print(error.localizedDescription, level: .showInProduction)
            ErrorHandler.shared.checkError(error, handler: onError)
        }
    }
    
    func getKidAccountIndex(kidAccount: KidAccount?) -> Int {
        return self.getKidAccountIndex(kidName: kidAccount?.kidProfile?.nickName)
    }
    
    func getKidAccountIndex(kidName: String?) -> Int {
        guard let nickName = kidName,
            !nickName.isEmpty,
            let myKidAccounts = self.kidAccounts else {
            return -1
        }
        
        return myKidAccounts.index(where: { $0.kidProfile?.nickName == nickName }) ?? -1
    }
}
