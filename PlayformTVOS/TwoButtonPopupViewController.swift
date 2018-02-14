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
 * TwoButtonPopupViewController.swift
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/7/13.
 */

import Foundation
import UIKit

protocol PUTwoButtonPopupViewControllerDelegate: PopupViewControllerDelegate{
    func didClickedConfirmtButton(genre: PopupTitleIndex)
    func didClickedCancelButton(genre: PopupTitleIndex)
}

class TwoButtonPopupViewController: PopupViewController {
    @IBOutlet weak var cancelButton: RoundButton!
    @IBOutlet weak var confirmButton: RoundButton!
    
    @IBAction func didClickeButton(_ sender: UIButton) {
        self.removeAnimate()
        
        if let delegate = (self.delegate as? PUTwoButtonPopupViewControllerDelegate) {
            if let genre = myGenre {
                if (sender == self.confirmButton){
                    delegate.didClickedConfirmtButton(genre:genre)
                }
                else if (sender == self.cancelButton){
                    delegate.didClickedCancelButton(genre:genre)
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func create(genre: PopupTitleIndex) {
        super.create(genre: genre)
        self.setContent()
    }
    override func setContent() {
        super.setContent()
        self.confirmButton.setTitle(context.comfirmButtontext,for: .normal)
        self.cancelButton.setTitle(context.cancelButtontext,for: .normal)
    }
}
