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
 * HomeTabBarController.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/7/5.
 */

import UIKit

enum TabBarType: Int {
    case Settings = 0
    case Logout = 1
    case Login = 2

    var description : String {
        switch self {
        case .Settings: return "Settings"
        case .Logout: return "Logout"
        case .Login: return "Login"
        }
    }

}

class HomeTabBarController: UITabBarController {
    weak var bgImageView: UIImageView?
    var isLogouting = false
    var isFirstTime = true
    
    func initial(isLogin: Bool) {
        
        guard var myVCs = self.viewControllers else {
            return
        }
        
        for vc in myVCs {
            guard let tabBar = vc.tabBarItem else {
                return
            }
            let title: String = tabBar.title ?? ""
            var removeIdx: Int = -1
            if (isLogin == true) {
                if(title == TabBarType.Login.description)
                {
                    removeIdx = myVCs.index(of: vc) ?? -1
                }
            } else {
                if(title == TabBarType.Settings.description ||
                    title == TabBarType.Logout.description)
                {
                    removeIdx = myVCs.index(of: vc) ?? -1

                }
            }
            if (removeIdx != -1) {
                myVCs.remove(at: removeIdx)
            }
        }
      
        self.setViewControllers(myVCs, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isHidden = true
        self.bgImageView = UIImageView(frame: self.view.bounds)
        self.setBackgroundImage(imageView: self.bgImageView, imageName: "home_bg")
        
        self.setupRecognizers()
        self.syncUserProfile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async(execute: {
            self.isFirstTime = true
        })
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if(self.isFirstTime == true) {
            self.tabBar.isHidden = true
            self.isFirstTime = false
        }
    }
}
