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
 * SettingDetailViewControllerswift
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/6/21.
 */

import Foundation
import UIKit

class SettingDetailViewController: UIViewController {
    @IBOutlet weak var settingDetailTableView: SettingDetailTableView!
    fileprivate var viewModel: SettingsDetailViewModelProtocol?
    var myType = SettingsSectionType.USER
    var loadingUI = UIAlertController()
    var indicator = UIActivityIndicatorView()
    
    var isShowLoadingUIDelay: Bool = false
    
    func initial(type: SettingsSectionType, viewModel: SettingsDetailViewModelProtocol) {
        self.myType = type
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleMenuPress))
        tapRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.menu.rawValue)]
        view.addGestureRecognizer(tapRecognizer)
    }
    
    func handleMenuPress(recognizer: UITapGestureRecognizer) {
        goBack()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(goPrivacy(_:)), name: NSNotification.Name(rawValue: SettingConstant.PRIVACY_VIEW_CONTROLLER), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showCreateKidSuccess), name: NSNotification.Name(rawValue: SettingConstant.Notification.CREATE_KID_SUCCESS), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showCreateKidIndicator), name: NSNotification.Name(rawValue: SettingConstant.Notification.SHOW_CREATE_KID_INDICATOR), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.unableToAddKids), name: NSNotification.Name(rawValue: SettingConstant.Notification.UNABLE_TO_ADD_KIDS), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.unableToUpdateInform), name: NSNotification.Name(rawValue: SettingConstant.Notification.UNABLE_TO_UPDATE_INFORM), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.showUpdatedInform), name: NSNotification.Name(rawValue: SettingConstant.Notification.UPDATE_INFORM_SUCCESS), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.unableToConnectHint), name: NSNotification.Name(rawValue: SettingConstant.Notification.UNABLE_TO_CONNECT_TO_SERVER), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.dismissLoading), name: NSNotification.Name(rawValue: SettingConstant.Notification.DISMISS_LOADING), object: nil)
        settingDetailTableView.initial(controller: self, viewModel: viewModel,type: self.myType)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: SettingConstant.PRIVACY_VIEW_CONTROLLER), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: SettingConstant.Notification.UPDATE_INFORM_SUCCESS), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: SettingConstant.Notification.CREATE_KID_SUCCESS), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: SettingConstant.Notification.SHOW_CREATE_KID_INDICATOR), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: SettingConstant.Notification.UNABLE_TO_CONNECT_TO_SERVER), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: SettingConstant.Notification.UNABLE_TO_ADD_KIDS), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: SettingConstant.Notification.UNABLE_TO_UPDATE_INFORM), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: SettingConstant.Notification.DISMISS_LOADING), object: nil)
    }

    func showCreateKidIndicator() {
        self.loadingUI = UIAlertController(title: NSLocalizedString("Creating_Kid", comment: ""), message: "", preferredStyle: .alert)
        self.indicator = UIActivityIndicatorView(frame: CGRect(x: loadingUI.view.bounds.minX, y: loadingUI.view.bounds.minY + 20, width: loadingUI.view.bounds.width, height: loadingUI.view.bounds.height))
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        loadingUI.view.addSubview(indicator)
        indicator.isUserInteractionEnabled = false
        indicator.startAnimating()
        indicator.hidesWhenStopped = true
        self.present(loadingUI, animated: true, completion: nil)
    }

    func unableToAddKids() {
        if(self.presentedViewController != nil) {
            DispatchQueue.main.async(execute: {
                self.indicator.stopAnimating()
                self.loadingUI.title = NSLocalizedString("add_kids_fail_title", comment: "")
                self.loadingUI.message = NSLocalizedString("add_kids_fail", comment: "")
            
                let actionRetry = UIAlertAction(title: NSLocalizedString("tryAgain", comment: ""), style: .default) { (action : UIAlertAction) -> Void in
                    self.viewModel?.sendDataAgain()
                }
                let actionDismiss = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel) { (action : UIAlertAction) -> Void in
                    self.goBack()
                }
                self.loadingUI.addAction(actionRetry)
                self.loadingUI.addAction(actionDismiss)
            })
        } else {
            
            let alert = UIAlertController()

            alert.title = NSLocalizedString("add_kids_fail_title", comment: "")
            alert.message = NSLocalizedString("add_kids_fail", comment: "")
            
            let actionRetry = UIAlertAction(title: NSLocalizedString("tryAgain", comment: ""), style: .default) { (action : UIAlertAction) -> Void in
                self.viewModel?.sendDataAgain()
            }
            let actionDismiss = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel) { (action : UIAlertAction) -> Void in
                self.goBack()
            }
            alert.addAction(actionRetry)
            alert.addAction(actionDismiss)
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    func unableToUpdateInform() {
        print("unableToUpdateInform")
        let alert = UIAlertController()
        alert.title = NSLocalizedString("update_inform_fail_title", comment: "")
        alert.message = NSLocalizedString("update_inform_fail", comment: "")
        
        let actionRetry = UIAlertAction(title: NSLocalizedString("tryAgain", comment: ""), style: .default) { (action : UIAlertAction) -> Void in
            self.viewModel?.sendDataAgain()
        }
        let actionDismiss = UIAlertAction(title: NSLocalizedString("cancel", comment: ""), style: .cancel) { (action : UIAlertAction) -> Void in
        }
        alert.addAction(actionRetry)
        alert.addAction(actionDismiss)
        self.present(alert, animated: true, completion: nil)
    }
    
    func unableToConnectHint() {
        
        self.indicator.stopAnimating()
        self.loadingUI.title = NSLocalizedString("error_unable_to_connect", comment: "")
        self.loadingUI.message = NSLocalizedString("error_unable_to_connect_subtitle", comment: "")
        
        let actionDismiss = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel) { (action : UIAlertAction) -> Void in
            self.goSetting()
        }
        loadingUI.addAction(actionDismiss)
    }
    
    func showUpdatedInform() {
        DispatchQueue.main.async(execute: {
            self.settingDetailTableView.setNextFocusRow()
            self.settingDetailTableView.reloadData()
        })
    }
    
    func showCreateKidSuccess() {
        self.indicator.stopAnimating()
        self.loadingUI.title = NSLocalizedString("account_Create_success", comment: "")
        self.loadingUI.message = NSLocalizedString("your_account_Create_success", comment: "")

        let actionContinue = UIAlertAction(title: NSLocalizedString("Continue_Editing", comment: ""), style: .default) { (action : UIAlertAction) -> Void in
            self.loadingUI.dismiss(animated: true, completion: nil)
            self.myType = SettingsSectionType.KIDS
            self.settingDetailTableView.initial(controller: self, viewModel: self.viewModel,type: self.myType)
            self.settingDetailTableView.reloadData()
        }
        let actionDismiss = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel) { (action : UIAlertAction) -> Void in
            self.goSetting()
        }
        loadingUI.addAction(actionContinue)
        loadingUI.addAction(actionDismiss)
    }
    
    func goSetting() {
        let vc = UISplitViewController.instantiate(from: .Settings)
        self.present(vc,animated: true)
    }
    
    func goBack() {
        DispatchQueue.main.async(execute: {
            self.dismiss(animated: true, completion: nil)
        })
    }

    
    func goPrivacy(_ button: UIButton) {
        let vc = PrivacyStatementWebViewController.instantiate(from: .Settings)
        self.present(vc, animated: true)
    }
    
    func dismissLoading() {
        DispatchQueue.main.async(execute: {
            self.loadingUI.dismiss(animated: true, completion: nil)
        })
    }
}

class AlertView: NSObject {
    
    class func showAlert(view: UIViewController , message: String) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        DispatchQueue.main.async(execute: {
            view.present(alert, animated: true, completion: nil)
        })
    }
}
// MARK: - SettingsCallbcak
