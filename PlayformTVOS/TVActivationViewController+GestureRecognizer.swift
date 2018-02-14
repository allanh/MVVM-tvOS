//
//  TVActivationViewController+GestureRecognizer.swift
//  PlayformTVOS
//
//  Created by allan.shih on 2017/8/9.
//  Copyright © 2017年 allan.shih. All rights reserved.
//
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
 * TVActivationViewController+GestureRecognizer.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/8/9.
 */

import UIKit

extension TVActivationViewController {
    
    /// Creates tap and gesture recognizer.
    func setupRecognizers() {        
        // Detecting a tap menu gesture on remote.
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.clickOnBack))
        tapRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.menu.rawValue)];
        self.view.addGestureRecognizer(tapRecognizer)
        
        // Detecting a tap select gesture on remote.
        let tapSelectRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedGetNewCode))
        tapSelectRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.select.rawValue)];
        self.view.addGestureRecognizer(tapSelectRecognizer)
    }
    
    @objc private func clickOnBack() {
        DispatchQueue.main.async(execute: { [weak self] in
            guard let safeSelf = self else {
                return
            }
            safeSelf.activationViewListener?.activationViewEventHandler = self
            safeSelf.activationViewListener?.onClickedBack(listener: nil)
        })
    }
    
    @objc private func tappedGetNewCode() {
        DispatchQueue.main.async(execute: { [weak self] in
            guard let safeSelf = self else {
                return
            }
            safeSelf.getNewCodeButton.isEnabled = true
            safeSelf.getNewCodeButton.setTitleColor(.black, for: .normal)
            safeSelf.closeHintLabel.isHidden = true
            safeSelf.setNeedsFocusUpdate()
            safeSelf.updateFocusIfNeeded()
        })
    }
}
