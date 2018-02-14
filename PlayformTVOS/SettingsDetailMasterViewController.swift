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
 * SettingsDetailMasterViewController.swift
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/6/21.
 */

import Foundation
import UIKit

class SettingsDetailMasterViewController: UIViewController {
    @IBOutlet weak var subTitleLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var mainTitleLbl: UILabel!
    var displayType: SettingsSectionType = SettingsSectionType.USER
    var viewModel: SettingsDetailViewModelProtocol?
    
    func SetTitle(type: SettingsSectionType, viewModel: SettingsDetailViewModelProtocol) {
        self.displayType = type
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        displayTitle()
    }
    
    func displayTitle() {
        switch (self.displayType) {
        case SettingsSectionType.KIDS:
            mainTitleLbl?.text =  NSLocalizedString("detail_kid_account_title", comment: "")
            emailLbl.isHidden = true
            subTitleLbl.isHidden = true
        case SettingsSectionType.ADDKIDS:
            mainTitleLbl?.text =  NSLocalizedString("detail_create_kids_title", comment: "")
            emailLbl.isHidden = true
            subTitleLbl.isHidden = true

        default:
            mainTitleLbl?.text =  NSLocalizedString("detail_user_profile_title", comment: "")
            emailLbl.isHidden = false
            subTitleLbl.isHidden = false
            emailLbl.text = viewModel?.getUserAccountStr()
        }
    }
    
}
