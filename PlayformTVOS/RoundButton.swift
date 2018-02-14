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
 * RoundButton.swift
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/6/20.
 */

import Foundation
import UIKit

@IBDesignable open class RoundButton: UIButton {
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //titleLabel?.font = UIFont(name: "Avenir Book", size: 32) ?? UIFont()
        titleLabel?.font = UIFont.systemFont(ofSize: 30)
    }
    
    override open func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        if context.nextFocusedView == self {
            layer.borderColor = focusBorderColor.cgColor
        } else {
            layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable
    var focusBorderColor: UIColor = UIColor.white
    
    @IBInspectable
    var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var focusTitleColor: UIColor = UIColor.white {
        didSet {
            setTitleColor(focusTitleColor, for: .focused)
        }
    }
    
    // swiftlint:disable valid_ibinspectable
    @IBInspectable
    var newTextFont: UIFont = UIFont.systemFont(ofSize: 32) {
        didSet {
            titleLabel?.font = newTextFont
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat = 1 {
        didSet {
            layer.cornerRadius = 0.1 * cornerRadius * bounds.size.height
            clipsToBounds = true
            layoutSubviews()
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
}



