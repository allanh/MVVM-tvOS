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
 * PrivacyStatementWebViewController.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/6/26.
 */


import UIKit

class PrivacyStatementWebViewController: UIViewController {

    @IBOutlet weak var psTitleLabel: UILabel!
    @IBOutlet weak var psTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.psTextView.isSelectable = true
        self.psTextView.isUserInteractionEnabled = true
        self.psTextView.panGestureRecognizer.allowedTouchTypes = [NSNumber(value: UITouchType.indirect.rawValue)]
        
        // Read a text file from Bundle.
        self.psTextView.text = "PrivacyStatement.txt".readFileFromBundle(Bundle.main)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
