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
 * LandingViewController+GestureRecognizer.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/6/23.
 */

import UIKit

extension LandingViewController {
    
    /// Creates tap and gesture recognizer.
    func setupRecognizers() {
        // Detecting a playPause gesture on View.
        let tapPlayPauseRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedPlayPause))
        tapPlayPauseRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.playPause.rawValue)];
        self.view.addGestureRecognizer(tapPlayPauseRecognizer)
    }
    
    /// The method is called when the PlayPause is pressed.
    func tappedPlayPause() {
        // Entering Debug Mode
        if self.tapCount > 5 {
            DispatchQueue.main.async(execute: {
                // To present the HomeViewController
                let vc = HomeTabBarController.instantiate(from: .Main)
                vc.initial(isLogin: true)
                self.present(vc, animated: true, completion: nil)
            })
        } else {
            self.tapCount += 1
        }
    }
}
