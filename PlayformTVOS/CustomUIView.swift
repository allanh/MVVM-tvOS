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
 * CustomUIView.swift
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/6/21.
 */

import Foundation
import UIKit

@IBDesignable open class CustomUIView: UIView {
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
    var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
}
