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
 * SettingsViewModel+KidAccount.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/6/26.
 */

import Foundation
import PlayformSDK_TV

extension SettingsViewModel {
    
    func setKidAccounts(_ kidsAccounts: [KidAccount]?) {
        self.kidsAccounts = kidsAccounts
    }
    
    func getKidsAccounts() -> [KidAccountPresentable] {
        var myKidsAccounts: [KidAccountPresentable] = []
        
        if let kidsAccounts = self.isFakeData ? self.mockKidsAccounts : self.kidsAccounts {
            for kidAccount in kidsAccounts {
                myKidsAccounts.append(MyKidAccount(kidAccount: kidAccount))
            }
        }
        
        return myKidsAccounts
    }
}
