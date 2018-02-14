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
 * LandingViewController.swift
 * PlayformTVOS
 *
 * Created by allan.shih on 2017/6/20.
 */

import UIKit
import PlayformSDK_TV

class LandingViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    weak var bgImageView: UIImageView?
    var tapCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgImageView = UIImageView(frame: self.view.bounds)
        self.setBackgroundImage(imageView: self.bgImageView, imageName: "landing_bg")
        self.setupRecognizers()
        
        //silentSignIn
        PlayformManager.silentSignIn(onSuccess: {
            // Success
            // After user logged in succeed, do anything that you want.
            DispatchQueue.main.async(execute: {
                // To present the HomeViewController
                let vc = HomeTabBarController.instantiate(from: .Main)
                vc.initial(isLogin: true)
                self.present(vc, animated: true, completion: nil)
            })
        }, onError: { (error) in
            // Error
            // Sign in fail and do something to handle the error occur.
            print("silentSignIn fail, error:\(error.localizedDescription)", level: .showInProduction)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHomeView" {
            print("go ot home view")
            if let nextViewController = segue.destination as? HomeTabBarController {
                nextViewController.initial(isLogin: false)
            }

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didClickWithoutSignIn(_ sender: UIButton) {
        let vc = HomeTabBarController.instantiate(from: .Main)
        vc.initial(isLogin: false)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didClickedAction(_ sender: UIButton) {
        print("clicked action")
        if sender == self.signInButton {
            PlayformManager.signInWithOtherDevice(onSuccess: {
                // Success
                // After user logged in succeed, do anything that you want.
                
                DispatchQueue.main.async(execute: {
                    // To present the HomeViewController
                    let vc = HomeTabBarController.instantiate(from: .Main)
                    vc.initial(isLogin: true)
                    self.present(vc, animated: true, completion: nil)
                })
            }, onError: { (error) in
                // Error
                // Sign in fail and do something to handle the error occur.
                print("signInWithOtherDevice fail, error:\(error.localizedDescription)", level: .showInProduction)
                ErrorHandler.shared.checkError(error, handler: nil)
            })
        }
    }

}
