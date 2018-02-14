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
 * TVAlertViewController.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/7/25.
 */

import UIKit
import PlayformSDK_TV

// Alert Type
public enum AlertType: Int, CustomStringConvertible {
    case unableToAddKid // Try Again, Cancel
    case unableToConnectToServer // Ok
    case accountCreationSuccessful // Continue Editing, Ok
    case unableToConnectToInternet // Ok
    case unableToUpdateInformation // Try Again, Cancel
    
    var title: String {
        switch self {
        case .unableToAddKid:               return NSLocalizedString("unable_to_add_kid", comment: "")
        case .unableToConnectToServer:      return NSLocalizedString("error_unable_to_connect", comment: "")
        case .accountCreationSuccessful:    return NSLocalizedString("account_Create_success", comment: "")
        case .unableToConnectToInternet:    return NSLocalizedString("unable_to_connect_internet", comment: "")
        case .unableToUpdateInformation:    return NSLocalizedString("unable_To_Update", comment: "")
        }
    }
    
    public var description: String {
        switch self {
        case .unableToAddKid:               return NSLocalizedString("unable_to_add_kid_message", comment: "")
        case .unableToConnectToServer:      return NSLocalizedString("error_unable_to_connect_subtitle", comment: "")
        case .accountCreationSuccessful:    return NSLocalizedString("your_account_Create_success", comment: "")
        case .unableToConnectToInternet:    return NSLocalizedString("unable_to_connect_internet_message", comment: "")
        case .unableToUpdateInformation:    return NSLocalizedString("unable_To_Update_Description", comment: "")
        }
    }
}

protocol AlertPresentable {
    func showAlert(view: UIViewController, title: String, message: String)
    func showAlert(view: UIViewController, title: String, message: String, actions: [UIAlertAction])
    func showAlert(view: UIViewController, type: AlertType, actions: [UIAlertAction]?)
}

class TVAlertViewController: AlertPresentable {
    // Initialize the instance with singleton
    internal static let shared = TVAlertViewController()
    
    private var dispathQueue: DispatchQueue = DispatchQueue.main
    
    var okAction: UIAlertAction = {
        return UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default)
    }()
    
    // MARK: - Show a simple alert with a single "OK" button.
    func showAlert(view: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Add the action.
        alertController.addAction(self.okAction)
        
        self.dispathQueue.async(execute: {
            view.present(alertController, animated: true, completion: nil)
        })
    }
    
    // MARK: - Shows an alert with some customized buttons.
    func showAlert(view: UIViewController, title: String, message: String, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Add the actions.
        for action in actions {
            alertController.addAction(action)
        }
        
        self.dispathQueue.async(execute: {
            view.present(alertController, animated: true, completion: nil)
        })
    }

    // MARK: - Show an alert with a AlertType and AlertActions.
    func showAlert(view: UIViewController, type: AlertType, actions: [UIAlertAction]? = nil) {
        if let alertActions = actions {
            self.showAlert(view: view, title: type.title, message: type.description, actions: alertActions)
        } else {
            self.showAlert(view: view, title: type.title, message: type.description)
        }
    }
    
    // MARK: - Set the dispath queue.
    internal func setDispathQueue(dispathQueue: DispatchQueue) {
        self.dispathQueue = dispathQueue
    }
}
