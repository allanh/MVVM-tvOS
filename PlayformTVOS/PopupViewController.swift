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
 * PopupViewControllerswift
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/7/13.
 */

import Foundation
import UIKit

protocol PopupViewControllerDelegate : class {}

class PopupViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var delegate: PopupViewControllerDelegate?
    var context: PopupInfo = PopupInfo()
    var myGenre: PopupTitleIndex?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(PopupViewController.removeAnimate), name: NSNotification.Name(rawValue: "NotifyRemovePopupView"), object: nil)
    }

    func showInVC(_ vc: UIViewController, delegateType: PopupViewControllerDelegate? = nil, genre: PopupTitleIndex, isAni: Bool = true) {
        UIApplication.shared.keyWindow?.addSubview(self.view)
        vc.addChildViewController(self)
        self.didMove(toParentViewController: vc)
        if (isAni) {
            self.showAnimate()
        }
        delegate = delegateType ?? (vc as? PopupViewControllerDelegate)
        self.create(genre: genre)
        self.setNeedsFocusUpdate()
        self.updateFocusIfNeeded()
    }
    
    func showInVC(_ vc:UIViewController, isAni:Bool = true) {
        UIApplication.shared.keyWindow?.addSubview(self.view)
        vc.addChildViewController(self)
        self.didMove(toParentViewController: vc)
        if (isAni) {
            self.showAnimate()
        }
    }
    
    func create(genre: PopupTitleIndex) {
        context = PopupData.shared.getPopupInfo(title: genre)
        myGenre = genre
    }
    
    func setContent(){
        self.titleLabel.text = context.title
        self.descriptionLabel.text = context.description
    }
    
    internal func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    internal func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.willMove(toParentViewController: nil)
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
            }
        });
    }

}

