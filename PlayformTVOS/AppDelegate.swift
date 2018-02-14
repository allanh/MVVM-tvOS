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
 * AppDelegate.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/6/20.
 */

import UIKit
import PlayformSDK_TV

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let env:PlayformEnvironment = PlayformEnvironment()
        env.application = application
        env.customViewDictionary = getCustomViewDictionary()
        
        // Initialize PlayformManager
        guard PlayformManager.initialize(env: env) else {
            // NOTE: When PlayformManager occur some error when being initial process.
            print("ERROR: PlayformManager doesn't be initialized successfully.")
            return true
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

// MARK: - Custom View Dictionary

extension AppDelegate {
    func getCustomViewDictionary() -> [String: CommonViewEventHandler] {
        var customViewDictionary: [String: CommonViewEventHandler] = [:]
        
        // Activation
        let activationVC = TVActivationViewController.instantiate(from: .TVActivation)
        let activationWithLegalVC = TVActivationViewController.instantiate(from: .TVActivation)

        customViewDictionary[ViewType.ActivationView.text()] = activationVC as CommonViewEventHandler
        customViewDictionary[ViewType.ActivationViewWithPendingAgreementMessage.text()] = activationWithLegalVC as CommonViewEventHandler

        return customViewDictionary
    }
}

