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
 * StoryboardDesignable.swift
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/6/22.
 */


import Foundation
import UIKit
/// How to use?
/// Step 1: Add Your Storyboards Name to Storyboard Enum

enum Storyboard: String {
    
    // Main
    case Main            = "Main"
    case TVActivation    = "TVActivation"
    case Settings        = "Settings"
    case Popup        = "Popup"
    case Loading        = "Loading"
}

// MARK: - StoryboardDesignable Protocol for UIViewController
///
/// Step 2: Edit your ViewController's 'Storyboard ID' is same the 'Class Name'
/// Step 3: let vc = YourViewController.instantiate(from .StoryboardName)

protocol StoryboardDesignable : class {}

extension StoryboardDesignable where Self : UIViewController {
    
    static func instantiate(from storyboard: Storyboard, bundle: Bundle? = nil) -> Self {
        
        let dynamicMetatype = Self.self
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: bundle)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "\(dynamicMetatype)") as? Self else {
            fatalError("Couldn’t instantiate view controller with identifier \(dynamicMetatype)")
        }
        
        return viewController
    }
}

extension UIViewController : StoryboardDesignable {}
