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
 * SettingsViewController.swift
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/6/21.
 */

import Foundation
import UIKit
import PlayformSDK_TV

enum SettingsSectionType: Int {
    case USER
    case KIDS
    case ADDKIDS
    case EMAIL
    case PRIVACY
}

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var mySettingsTableView: SettingsTableView!
    
    fileprivate var viewModel: SettingsViewModelProtocol!

    @IBAction func deleteallKids(_ sender: UIButton) {
        for i in viewModel.getKidsAccounts() {
            i.deleteKidAccount(onSuccess: {
             }, onError: { (Error) in
             })
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(goUserProfile(_:)), name: NSNotification.Name(rawValue: SettingConstant.USER_PROFILE_VIEW_CONTROLLER), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goKidProfile(_:)), name: NSNotification.Name(rawValue: SettingConstant.CREATE_KID_PROFILE_VIEW_CONTROLLER), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goCreateKid(_:)), name: NSNotification.Name(rawValue: SettingConstant.KID_PROFILE_VIEW_CONTROLLER), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goEmailVerify(_:)), name: NSNotification.Name(rawValue: SettingConstant.VERIFY_EMAIL_VIEW_CONTROLLER), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goPrivacy(_:)), name: NSNotification.Name(rawValue: SettingConstant.PRIVACY_VIEW_CONTROLLER), object: nil)
        
        initialDataModel()
        
        // Detecting a tap gesture on view.
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.clickOnBack))
        tapRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.menu.rawValue)];
        self.view.addGestureRecognizer(tapRecognizer)
        
        setUserEmail()
    }

    func initialDataModel() {
        // Create a new SettingsViewModel instance with the user profile and callback.
        self.viewModel = SettingsViewModel(
            userProfile: SettingsManager.shared.userProfile,
            kidAccounts: SettingsManager.shared.kidAccounts,
            settingsCallback: reloadViewData)
        
        mySettingsTableView.initial(controller: self, viewModel: self.viewModel)
        self.mySettingsTableView?.reloadData()
    }
    
    func setUserEmail() {
        guard let viewControllers = self.splitViewController?.viewControllers else {
            return
        }
        if let naVC = viewControllers.first as? UINavigationController {
            if let masterVC = naVC.viewControllers.first as? SettingsMasterViewController {
                masterVC.setAccount(user: SettingsManager.shared.userProfile ?? UserProfile())
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: SettingConstant.USER_PROFILE_VIEW_CONTROLLER), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: SettingConstant.CREATE_KID_PROFILE_VIEW_CONTROLLER), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: SettingConstant.KID_PROFILE_VIEW_CONTROLLER), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: SettingConstant.VERIFY_EMAIL_VIEW_CONTROLLER), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: SettingConstant.PRIVACY_VIEW_CONTROLLER), object: nil)
    }
    
    func goUserProfile(_ button: UIButton) {
        let vc = SettingsDetailSplitController.instantiate(from: .Settings)
        vc.setDetailView(type: SettingsSectionType.USER, nextViewModel: viewModel.getNextViewControllerViewModel(index: mySettingsTableView.getLastSelectIndex().row, type: SettingsSectionType.USER))
        DispatchQueue.main.async(execute: {
            self.present(vc, animated: true)
        })
    }
    
    func goKidProfile(_ button: UIButton) {
        let vc = SettingsDetailSplitController.instantiate(from: .Settings)
        vc.setDetailView(type: SettingsSectionType.KIDS, nextViewModel: viewModel.getNextViewControllerViewModel(index: mySettingsTableView.getLastSelectIndex().row, type: SettingsSectionType.KIDS))
        DispatchQueue.main.async(execute: {
            self.present(vc, animated: true)
        })
    }
    
    func goCreateKid(_ button: UIButton) {
        let vc = SettingsDetailSplitController.instantiate(from: .Settings)
        vc.setDetailView(type: SettingsSectionType.ADDKIDS, nextViewModel: viewModel.getNextViewControllerViewModel(index: mySettingsTableView.getLastSelectIndex().row, type: SettingsSectionType.ADDKIDS))
        DispatchQueue.main.async(execute: {
            self.present(vc, animated: true)
        })
    }
    
    func goPrivacy(_ button: UIButton) {
        let vc = PrivacyStatementWebViewController.instantiate(from: .Settings)
        DispatchQueue.main.async(execute: {
            self.present(vc, animated: true)
        })
    }
    
    func goEmailVerify(_ button: UIButton) {
        let vc = VerifyEmailViewController.instantiate(from: .Settings)
        vc.setViewModel(self.viewModel)
        DispatchQueue.main.async(execute: {
            self.present(vc, animated: true)
        })
    }
    
    func clickOnBack() {
        DispatchQueue.main.async(execute: {
            self.dismiss(animated: true, completion: nil)
        })
    }
}

// MARK: - SettingsCallbcak

extension SettingsViewController {
    func reloadViewData(viewModel: SettingsViewModelProtocol) {
        print("[SettingsViewController] reload settings view data")
        self.viewModel = viewModel
        
        DispatchQueue.main.async {
            self.mySettingsTableView?.reloadData()
        }
    }
}
