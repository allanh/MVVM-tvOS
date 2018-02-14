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
 * UIApplication+TopViewController.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/6/29.
 */


import UIKit

protocol TopViewControllerAccessible {
    static func topViewController() -> UIViewController?
    static func topViewController(base: UIViewController?) -> UIViewController?
}

extension UIApplication: TopViewControllerAccessible {
    
    static func topViewController() -> UIViewController? {
        return self.topViewController(base: UIApplication.shared.keyWindow?.rootViewController)
    }
    
    ///  To find the topViewController on UIApplication Stack, and from there present your controller.
    static func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            
            // The UISystemInputViewController don't belong to this target.
            guard let className = presented.className,
                className != "UISystemInputViewController" else {
                return base
            }
            
            return topViewController(base: presented)
        }
        return base
    }
}
