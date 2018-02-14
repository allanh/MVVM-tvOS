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
 * SettingsMasterViewController.swift
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/6/22.
 */

import Foundation
import UIKit
import PlayformSDK_TV

class SettingsMasterViewController: UIViewController {
    
    @IBOutlet weak var helloText: UILabel!
    @IBOutlet weak var userAccountLbl: UILabel!
    var user: UserProfile?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if (self.user != nil) {
            if (self.user?.firstName != nil) {
                helloText.text = NSLocalizedString("hello", comment: "") + "," + (self.user?.firstName ?? "")
            } else {
                helloText.isHidden = true
            }
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.setNeedsFocusUpdate()
        self.updateFocusIfNeeded()
    }
    
    func setAccount(user: UserProfile) {
        self.user = user
    }
}
