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
 * SettingsViewModel.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/6/22.
 */

import Foundation
import PlayformSDK_TV

typealias SettingsCallbcak = ((SettingsViewModelProtocol) -> ())?

protocol SettingsViewModelProtocol {
    
    var isFakeData: Bool { get set }
    var kidsCountLimit: Int { get set }

    // MARK: - initializers

    init(userProfile: UserProfile?, kidAccounts: [KidAccount]?, settingsCallback: SettingsCallbcak?)
    
    // MARK: - Methods

    func setUserProfile(_ userProfile: UserProfile?)
    func getUserProfile() -> UserProfilePresentable?
    func setKidAccounts(_ kidsAccounts: [KidAccount]?)
    func getKidsAccounts() -> [KidAccountPresentable]
    
    func save(onSuccess:@escaping ()->(), onError:@escaping (_ error:Error)->())
    func getNextViewControllerViewModel(index: Int, type: SettingsSectionType) -> SettingsDetailViewModelProtocol
}

class SettingsViewModel: SettingsViewModelProtocol, SettingsManagerDelegate {
    
    var settingsCallback: SettingsCallbcak?
    var isFakeData: Bool = true
    var kidsCountLimit: Int = 5 //Override if this limit download from server-side in the future.
    
    var userProfile: UserProfile? {
        didSet {
            self.dataDidChanged()
        }
    }
    
    var kidsAccounts: [KidAccount]? {
        didSet {
            self.dataDidChanged()
        }
    }
    
    // MARK: - initializers

    required init(userProfile: UserProfile?, kidAccounts: [KidAccount]?, settingsCallback: SettingsCallbcak?) {
        self.isFakeData = Bool(userProfile == nil)
        self.userProfile = userProfile ?? self.mockUserProfile
        self.kidsAccounts = kidAccounts
        self.settingsCallback = settingsCallback
        SettingsManager.shared.delegate = self
    }
    
    // MARK: - Methods
    
    func save(onSuccess: @escaping ()->(), onError: @escaping (_ error:Error)->()) {
        guard let userProfile = self.userProfile else {
            print("no userProfile")
            return
        }
        
        UserManager.updateUserProfile(profile: userProfile, onSuccess: { (userProfile) in
            onSuccess()
        }, onError: { (error) in
            ErrorHandler.shared.checkError(error, handler: onError)
        })
    }
    
    private func dataDidChanged() {
        guard let callback = self.settingsCallback else {
            return
        }
        callback?(self)
    }
    
    func getNextViewControllerViewModel(index: Int, type: SettingsSectionType) -> SettingsDetailViewModelProtocol {
        //var kidProfile : KidAccountPresentable = MyKidAccount(kidAccount: mockKidsAccounts?.first)
        var kidProfile: KidAccountPresentable?
        if(type == SettingsSectionType.KIDS && getKidsAccounts().count > index) {
            kidProfile = getKidsAccounts()[index]
        } else if (type == SettingsSectionType.ADDKIDS) {
            let kidAccount = KidAccount()
            kidProfile = MyKidAccount(kidAccount: kidAccount)
        }

        let nextViewControllerViewModel = SettingsDetailViewModel(type: type , index: index, profile: self.userProfile, kidProfile: kidProfile)
        nextViewControllerViewModel.isFakeData = isFakeData
        nextViewControllerViewModel.viewModel = self
        return nextViewControllerViewModel
    }
    
    // SettingsManagerDelegate
    
    func didReceiveUserProfile(_ userProfile: UserProfile) {
        self.userProfile = userProfile
    }
    
    func didReceiveKidAccounts(_ kidAccounts: [KidAccount]){
        self.kidsAccounts = kidAccounts
    }
}
