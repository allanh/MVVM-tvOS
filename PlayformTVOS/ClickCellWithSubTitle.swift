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
 * ClickCellWithSubTitle.swift
 * PlayformTVOSTests
 *
 * Created by sue.liu on 2017/6/26.
 */

import Foundation
import UIKit

class ClickCellWithSubTitle: CustomCell, SettingsCellReciever {
  
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var subTitleText: UILabel!
    
    var cacheFontColorTitle = UIColor.black
    var cacheFontColorSub = UIColor.black

    func setViewModelData(settingsCellViewModel: SettingsViewModelProtocol?, tableView: SettingsTableView, idx: Int, type: SettingsSectionType) {
        
        switch (type) {
            default:
                titleText.text = NSLocalizedString("email_veri_title", comment: "")
                if(settingsCellViewModel?.getUserProfile()?.primaryEmail?.isVerifiedEmail == true) {
                    subTitleText.text = NSLocalizedString("email_verified", comment: "")
                } else {
                    subTitleText.text = NSLocalizedString("email_not_verified", comment: "")
                }
            }
    }

    override func initGui() {
        super.initGui()
        cacheFontColorTitle = titleText.textColor
        cacheFontColorSub = subTitleText.textColor
    }
    
    override func setFont(color: UIColor) {
        titleText.textColor = color
        subTitleText.textColor = color
    }
}
