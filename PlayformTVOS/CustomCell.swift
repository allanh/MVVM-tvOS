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
 * CustomCell.swoft
 * PlayformTVOSTests
 *
 * Created by sue.liu on 2017/6/26.
 */

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    
    @IBInspectable var focusLightBgColor: UIColor = UIColor.white
    @IBInspectable var focusDarkBgColor: UIColor = UIColor.white
    
    @IBInspectable var focusLightTextColor: UIColor = UIColor.white
    @IBInspectable var focusDarkTextColor: UIColor = UIColor.white
    
    @IBInspectable var unFocusLightBgColor: UIColor = UIColor.white
    @IBInspectable var unFocusDarkBgColor: UIColor = UIColor.white
    
    @IBInspectable var unFocusLightTextColor: UIColor = UIColor.white
    @IBInspectable var unFocusDarkTextColor: UIColor = UIColor.white
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initGui()
    }
    
    func initGui() {
        guard(traitCollection.responds(to: #selector(getter: UITraitCollection.userInterfaceStyle)))
            else { return }
        
        let style = traitCollection.userInterfaceStyle
        
        switch (style) {
        case .dark:
            resetUI(isDark: true)
        default:
            resetUI(isDark: false)
        }

    }
    
    func setFont(color: UIColor) {
        //abstract
    }
    
    func setFocusUI(isDark: Bool) {
        //abstract
        if(isDark == true) {
            backgroundColor = focusDarkBgColor
            setFont(color: focusDarkTextColor)
        } else {
            backgroundColor = focusLightBgColor
            setFont(color: focusLightTextColor)
        }
    }
    
    func resetUI(isDark: Bool) {
        if(isDark == true) {
            backgroundColor = unFocusDarkBgColor
            setFont(color: unFocusDarkTextColor)
        } else {
            backgroundColor = unFocusLightBgColor
            setFont(color: unFocusLightTextColor)
        }
    }
    
    func getUserInterfaceStyle() -> UIUserInterfaceStyle {
        guard(traitCollection.responds(to: #selector(getter: UITraitCollection.userInterfaceStyle)))
            else { return .light}
        return traitCollection.userInterfaceStyle
    }
    
    override open func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        super.didUpdateFocus(in: context, with: coordinator)
        let style = getUserInterfaceStyle()
        switch (style) {
            case .dark:
                if context.nextFocusedView == self {
                    setFocusUI(isDark: true)
                } else {
                    resetUI(isDark: true)
                }
            default:
                if context.nextFocusedView == self {
                    setFocusUI(isDark: false)
                } else {
                    resetUI(isDark: false)
                }
            
        }
    }
}
