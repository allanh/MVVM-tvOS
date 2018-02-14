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
 * SettingsTableView.swift
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/6/21.
 */

import Foundation
import UIKit

class SettingsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    var controller: SettingsViewController = SettingsViewController()
    fileprivate var viewModel: SettingsViewModelProtocol?
    var focusType: SettingsSectionType = SettingsSectionType.USER
    var focusRow: Int = 0
    var lastSelectIndexPath: IndexPath = IndexPath()
    
    func getLastSelectIndex() -> IndexPath {
        return lastSelectIndexPath
    }
    
    func initial(controller: SettingsViewController, viewModel: SettingsViewModelProtocol?) {
        self.delegate = self
        self.dataSource = self
        self.controller = controller
        self.viewModel = viewModel
    }
    
    func getCountbyType(type: SettingsSectionType) -> Int {
        if(type == SettingsSectionType.KIDS) {
            guard let kidAccounts = viewModel?.getKidsAccounts() else {
                return 0
            }
            return kidAccounts.count
        } else if (type == SettingsSectionType.ADDKIDS){
            guard let kidAccounts = viewModel?.getKidsAccounts() else {
                return 0
            }
            if (kidAccounts.count >= viewModel?.kidsCountLimit ?? 5) {
                return 0
            } else {
                return 1
            }
        }
        else {
            return 1
        }
    }
    
    func getCellbyType(type: SettingsSectionType, idx: Int) -> UITableViewCell {
        var cellName: String = ""
        switch (type) {
        case SettingsSectionType.EMAIL:
            cellName = "ClickCellWithSubTitle"
        default:
            cellName = "ClickAndEnterCell"
        }
        
        if let cell = self.dequeueReusableCell(withIdentifier: cellName) as? SettingsCellReciever {
            cell.setViewModelData(settingsCellViewModel: self.viewModel , tableView: self, idx: idx, type: type)
            
            if let tempCell: UITableViewCell = cell as? UITableViewCell{
                return tempCell
            }else{
                return UITableViewCell()
            }

        } else{
            return UITableViewCell()
        }
    }

    func getSectionTitle(type: SettingsSectionType) -> String {

        switch (type) {
        case SettingsSectionType.USER :
            return NSLocalizedString("your_account_title", comment: "")
        case SettingsSectionType.KIDS :
            return NSLocalizedString("kid_account_title", comment: "")
        case SettingsSectionType.EMAIL :
            return NSLocalizedString("email_veri_title", comment: "")
            
        default:
            return ""
        }
    }
    
    func numberOfSections( in _tableView: UITableView) -> Int {
        return SettingsSectionType.PRIVACY.hashValue + 1
    }
    
    func tableView( _ tableView : UITableView,  titleForHeaderInSection section: Int)->String? {
        return getSectionTitle(type: SettingsSectionType(rawValue: section) ?? SettingsSectionType.USER)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let type: SettingsSectionType = SettingsSectionType(rawValue: section) {
            return getCountbyType(type: type)
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lastSelectIndexPath = indexPath
        if let type: SettingsSectionType = SettingsSectionType(rawValue: indexPath.section) {
            switch (type) {
                case SettingsSectionType.USER :
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: SettingConstant.USER_PROFILE_VIEW_CONTROLLER), object: nil)
                case SettingsSectionType.KIDS :
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: SettingConstant.CREATE_KID_PROFILE_VIEW_CONTROLLER), object: nil)
                case SettingsSectionType.ADDKIDS :
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: SettingConstant.KID_PROFILE_VIEW_CONTROLLER), object: nil)
                case SettingsSectionType.PRIVACY :
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: SettingConstant.PRIVACY_VIEW_CONTROLLER), object: nil)
                case SettingsSectionType.EMAIL :
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: SettingConstant.VERIFY_EMAIL_VIEW_CONTROLLER), object: nil)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 23)
        header.textLabel?.textColor = UIColor.darkGray
        
        guard(traitCollection.responds(to: #selector(getter: UITraitCollection.userInterfaceStyle)))
            else { return }
        
        let style = traitCollection.userInterfaceStyle
        
        if(style == .dark) {
            header.textLabel?.textColor = UIColor.white
        } else {
            header.textLabel?.textColor = UIColor.black
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let type: SettingsSectionType = SettingsSectionType(rawValue: indexPath.section) {
            return getCellbyType(type: type, idx: indexPath.row)
        }
        return UITableViewCell()
        
    }
}
