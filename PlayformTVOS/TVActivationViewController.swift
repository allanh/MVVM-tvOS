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
 * TVActivationViewController.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/6/23.
 */

import UIKit
import PlayformSDK_TV

class TVActivationViewController: ActivationViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleDescriptionTextView: UITextView!
    @IBOutlet weak var visitHintLabel: UILabel!
    @IBOutlet weak var activationHintLabel: UILabel!
    @IBOutlet weak var signInHintLabel: UILabel!
    @IBOutlet weak var activateUrlLabel: UILabel!
    @IBOutlet weak var activationCodeTitleLabel: UILabel!
    @IBOutlet weak var activationCodeValueLabel: UILabel!
    @IBOutlet weak var closeHintLabel: UILabel!

    @IBOutlet weak var getNewCodeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Disabling the get new code button
        self.getNewCodeButton.isEnabled = false
        self.getNewCodeButton.setTitleColor(.white, for: .normal)
        self.closeHintLabel.isHidden = false
        
        // Configuring the title, description and back button.
        self.titleLabel.text = self.viewType.title()
        self.titleDescriptionTextView.text = self.viewType.description()
        
        self.setupRecognizers()
        
        // Register the observer for App enter background
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appMovedToBackground),
            name: Notification.Name.UIApplicationWillResignActive,
            object: nil
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop listening notification
        NotificationCenter.default.removeObserver(
            self,
            name: Notification.Name.UIApplicationWillResignActive,
            object: nil
        )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func onReceiveActivationInfo(activationInfo: ActivationInfo) {
        guard let userCodeStr = activationInfo.userCode else {
            return
        }
        
        DispatchQueue.main.async(execute: { [weak self] in
            if self?.activationCodeValueLabel != nil {
                self?.activationCodeValueLabel.text = userCodeStr
            }
            if self?.activateUrlLabel != nil {
                self?.activateUrlLabel.text = activationInfo.verificationUrl
            }
        })
    }
    
    override func onDismissActivationView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didClickedAction(_ sender: UIButton) {
        if sender == self.getNewCodeButton {
            self.activationViewListener?.activationViewEventHandler = self
            self.activationViewListener?.onClickedGetANewCode()
        }
    }
    
    // MARK: - Notification Observer
    
    func appMovedToBackground() {
        DispatchQueue.main.async(execute: { [weak self] in
            guard let safeSelf = self else {
                return
            }
            safeSelf.activationViewListener?.activationViewEventHandler = self
            safeSelf.activationViewListener?.onClickedGetANewCode()
        })
    }
}
