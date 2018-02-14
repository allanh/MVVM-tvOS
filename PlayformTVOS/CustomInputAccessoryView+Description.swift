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
 * CustomInputAccessoryView+Description.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/7/11.
 */

import UIKit

protocol DescriptionViewPresentable {
    func setMessage(_ description: String?, level: HintLevel, interfaceStyle: UIUserInterfaceStyle)
    func removeDescriptionView()
}

// MARK: - DescriptionViewPresentable

extension CustomInputAccessoryView: DescriptionViewPresentable {
    
    /// Set the string to description text view.
    func setMessage(_ description: String?, level: HintLevel = .Normal, interfaceStyle: UIUserInterfaceStyle) {
        guard let descriptionString = description else {
            return
        }
        self.descriptionString = descriptionString
        self.descriptionView.text = descriptionString
        
        if (level == HintLevel.Warning) {
            self.descriptionView.textColor = .red
        } else {
            if(interfaceStyle == .dark) {
                self.descriptionView.textColor = .white
            } else {
                self.descriptionView.textColor = .black
            }
        }
        
        // Turn off all constraints in the view
        NSLayoutConstraint.deactivate(self.constraints)
        
        // Update all Constraints
        self.updateTitleWithDescriptionConstraints()
    }
    
    /// Remove the DescriptionView from the InputAccessoryView.
    func removeDescriptionView() {
        NSLayoutConstraint.deactivate(self.constraints)
        NSLayoutConstraint.deactivate(self.descriptionView.constraints)
        
        self.descriptionString = nil
        self.updateTitleConstraints()
    }
    
    /// Add layout constraints to the label that specifies it must fill the
    /// containing view with an additional 60pts of bottom padding.
    private func updateTitleConstraints() {
        NSLayoutConstraint.activate(self.titleHorizontalConstraints)
        NSLayoutConstraint.activate(self.verticalConstraints)
    }
    
    /// Add layout constraints to the label and the textview that specifies it must fill the
    /// containing view with an additional 60pts of bottom padding.
    private func updateTitleWithDescriptionConstraints() {
        NSLayoutConstraint.activate(self.titleHorizontalConstraints)
        NSLayoutConstraint.activate(self.descriptionHorizontalConstraints)
        NSLayoutConstraint.activate(self.verticalConstraints)
    }
}
