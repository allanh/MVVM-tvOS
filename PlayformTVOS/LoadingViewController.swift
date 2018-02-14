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
 * LoadingViewController.swift
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/7/13.
 */

import Foundation
import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var myIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myIndicator.startAnimating()
    }
}
