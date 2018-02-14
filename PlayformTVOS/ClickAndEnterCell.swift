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
 * ClickAndEnterCell.swift
 * PlayformTVOSTests
 *
 * Created by sue.liu on 2017/6/26.
 */

import Foundation
import UIKit

class ClickAndEnterCell: CustomCell, SettingsCellReciever {
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    var cacheFontColorTitle = UIColor.black

    func setViewModelData(settingsCellViewModel: SettingsViewModelProtocol?, tableView: SettingsTableView, idx: Int, type: SettingsSectionType) {
        switch type {
            
        case SettingsSectionType.USER:
            titleText.text = settingsCellViewModel?.getUserProfile()?.primaryEmail?.email ?? NSLocalizedString("user_profile", comment: "")

        case SettingsSectionType.ADDKIDS:
           titleText.text = NSLocalizedString("create_kids", comment: "")
            
        case SettingsSectionType.PRIVACY:
           titleText.text = NSLocalizedString("privacy_statement", comment: "")
            
        default:
            guard let kidsAccounts = settingsCellViewModel?.getKidsAccounts(),
                idx < kidsAccounts.count else {
                    print("Unable to get the kid Account.", level: .showInProduction)
                    return
            }
            titleText.text = kidsAccounts[idx].kidNickName
        }
    }
    
    override func initGui() {
        super.initGui()
        cacheFontColorTitle = titleText.textColor
    }
    
    override func setFont(color: UIColor) {
        titleText.textColor = color
    }
    
    override func setFocusUI(isDark: Bool) {
        super.setFocusUI(isDark: isDark)
        if(isDark) {
            arrowImg.image = UIImage(named: "btn_graph_next_disable")
        }
    }
    
    override func resetUI(isDark: Bool) {
        super.resetUI(isDark: isDark)
        if(isDark) {
            arrowImg.image = UIImage(named: "btn_header_back")
        }

    }


}
