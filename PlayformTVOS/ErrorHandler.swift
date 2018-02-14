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
 * ErrorHandler.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/7/26.
 */

import UIKit
import PlayformSDK_TV

typealias OtherErrorHanlder = (_ error: Error)->()

protocol ErrorHandling {
    func checkError(_ error: Error, handler: OtherErrorHanlder?)
}

class ErrorHandler: ErrorHandling {
    
    // Initialize the instance with singleton
    internal static let shared = ErrorHandler()
    
    // MARK: - Private properites
    private var alertController: AlertPresentable = TVAlertViewController.shared
    private var topVCAccessible: TopViewControllerAccessible.Type = UIApplication.self
    
    // MARK: - Error handling
    func checkError(_ error: Error, handler: OtherErrorHanlder?) {
        // To find the topViewController on UIApplication Stack
        guard let view = self.topVCAccessible.topViewController() else {
            print("[ErrorHandler] call other handler")
            if let otherHandler = handler {
                otherHandler(error)
            }
            return
        }
        
        print("[ErrorHandler] view name: \(String(describing: view.className))")

        self.checkError(error, view: view, handler: handler)
    }
    
    // MARK: - Error handling
    func checkError(_ error: Error, view: UIViewController, handler: OtherErrorHanlder?) {
        let err = error as NSError
        
        // Create the action.
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default) { _ in
            if let otherHandler = handler {
                otherHandler(error)
            }
        }
        
        // Get the alert type by error code.
        if let alertType = getAlertType(errorCode: err.code) {
            self.alertController.showAlert(view: view,
                                           type: alertType,
                                           actions: [okAction])
        } else {
            if let otherHandler = handler {
                otherHandler(error)
            }
        }
    }
    
    // MARK: - Get the alert type by error code.
    func getAlertType(errorCode: Int) -> AlertType? {
        switch errorCode {
        case 400...499, ERROR_CODE.HTTP_RESPONSE_DATA_ERROR: // Unable to connect server
            return .unableToConnectToServer
            
        case ERROR_CODE.UNABLE_TO_CONNECT_INTERNET:
            return .unableToConnectToInternet
            
        default:
            return nil
        }
    }
        
    // MARK: - Set Protocol.Type

    internal func setAlertController(_ alertController: AlertPresentable) {
        self.alertController = alertController
    }
    
    internal func setTopViewControllerAccessible(_ topVCAccessible: TopViewControllerAccessible.Type) {
        self.topVCAccessible = topVCAccessible
    }
}
