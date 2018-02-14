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
 * HomeTabBarController+PlayformSDK.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/7/6.
 */

import UIKit
import PlayformSDK_TV

extension HomeTabBarController {
    
    /// Sync the user profile with SettingsManager.
    func syncUserProfile() {
        SettingsManager.shared.syncUserProfile()
    }
    
    /// Sign out using PlayformManager.
    func signOut() {
        guard !self.isLogouting else {
            return
        }
        self.isLogouting = true
        
        // MARK: Logout Playform Service
        PlayformManager.signOut(onSuccess: {
            // Success
            // After logout in succeed, do anything that you want.
            self.goLanding()
        }, onError: { (error) in
            // Error
            self.isLogouting = false
            
            // Logout fail and do something to handle the error occur.
            print("Logout fail, error: \(error.localizedDescription)", level: .showInProduction)
            
            ErrorHandler.shared.checkError(error, handler: {(error) in
                self.goLanding()
            })
        })
    }
    
    func goLanding() {
        DispatchQueue.main.async(execute: {
            self.dismiss(animated: true, completion: nil)
        })
    }
}
