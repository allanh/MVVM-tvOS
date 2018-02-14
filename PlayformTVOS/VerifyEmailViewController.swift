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
 * VerifyEmailViewController.swift
 * PlayformTVOS
 *
 * Created by sunny.chen on 2017/6/30.
 */

import Foundation
import UIKit
import PlayformSDK_TV

class VerifyEmailViewController: UIViewController {

    private var viewModel: SettingsViewModelProtocol?
    @IBOutlet weak var userEmail: UILabel!

    func setViewModel(_ viewModel: SettingsViewModelProtocol?) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmail.text = viewModel?.getUserProfile()?.primaryEmail?.email ?? "john.smith2@mattel.com"
    }
    
    @IBAction func resendEmail(_ sender: UIButton) {
        UserManager.sendVerificationMail(onSuccess: {
            self.clickOnBack()
        }, onError: { (error) in
            print(error.localizedDescription)
            ErrorHandler.shared.checkError(error, view: self, handler: nil)
        })
    }
    
    @IBAction func backToAccountSetting(_ sender: UIButton) {
        clickOnBack()
    }
    
    func clickOnBack() {
        DispatchQueue.main.async(execute: {
            self.dismiss(animated: true, completion: nil)
        })
    }
}
