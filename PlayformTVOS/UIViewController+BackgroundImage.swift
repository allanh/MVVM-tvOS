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
 * UIViewController+BackgroundImage.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/7/6.
 */


import UIKit

extension UIViewController {
    /// Set UIViewController background image to fill screen
    ///
    /// - Parameter imageName: Background image
    func setBackgroundImage(imageView: UIImageView? = nil, imageName: String) {
        
        let bgImageView: UIImageView = imageView ?? UIImageView(frame: self.view.bounds)
        bgImageView.image = UIImage(named: imageName)
        bgImageView.layer.zPosition = -1
        
        self.view.addSubview(bgImageView)
    }
    
    
    /// Getting the classname as string 
    var className: String? {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last
    }
}
