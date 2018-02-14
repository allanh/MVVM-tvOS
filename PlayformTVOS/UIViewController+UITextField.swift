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
 * UIViewController+UITextField.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/7/3.
 */

import UIKit

extension UIViewController: UITextFieldDelegate {
    
    /// Dismiss the keyboard of UITextField when tap Return button.
    ///
    /// - Parameter textField: Input TextField
    func closeKeyboardWhenReturnClicked(textField: UITextField) {
        textField.delegate = self
    }
    
    // MARK: - UITextFieldDelegate

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
