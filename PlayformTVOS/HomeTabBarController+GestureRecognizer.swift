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
 * HomeTabBarController+GestureRecognizer.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/7/6.
 */

import UIKit

extension HomeTabBarController {
    
    /// Creates tap and gesture recognizer.
    func setupRecognizers() {
        // Detecting a tap gesture on TabBar.
        let tapTabBarRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedOnTabBar))
        tapTabBarRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.select.rawValue)];
        self.tabBar.addGestureRecognizer(tapTabBarRecognizer)
        
        // Detecting a tap gesture on View.
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tappedOnView))
        tapRecognizer.allowedPressTypes = [NSNumber(value: UIPressType.menu.rawValue)];
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    /// The method is called when the focus on TabBar and the select button is pressed.
    @objc private func tappedOnTabBar(gesture: UITapGestureRecognizer) {
        guard let tabBarTitle = self.tabBar.items?[selectedIndex].title else {
            return
        }
        
        self.tabBar.isHidden = true
        switch tabBarTitle {
        case TabBarType.Settings.description:
            let vc = UISplitViewController.instantiate(from: .Settings)
            DispatchQueue.main.async(execute: {
                self.present(vc, animated: true, completion: nil)
            })
            
        case TabBarType.Logout.description:
            self.signOut()
        
        default:
            self.dismiss(animated: true, completion: nil)
        }
    }

    /// The method is called when the focus on View and the select button is pressed.
    @objc private func tappedOnView(gesture: UITapGestureRecognizer) {
        self.tabBar.isHidden = false
    }
}
