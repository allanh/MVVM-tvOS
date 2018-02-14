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
 * SettingsDetailSplitController.swift
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/6/21.
 */

import Foundation
import UIKit

class SettingsDetailSplitController: UISplitViewController {
    func setDetailView(type: SettingsSectionType, nextViewModel: SettingsDetailViewModelProtocol) {
        
        if let navController = self.viewControllers.first as? UINavigationController {
            if let controller = navController.topViewController as? SettingsDetailMasterViewController {
                controller.SetTitle(type: type, viewModel: nextViewModel)
            }
        }
        
        if let detailController = self.viewControllers.last as? SettingDetailViewController {
            detailController.initial(type: type, viewModel: nextViewModel)
        }
        
//        switch (type) {
//            case SettingsSectionType.KIDS:
//                let vc = KidProfileViewController.instantiate(from: .Settings)
//                self.showDetailViewController(vc, sender: nil)
//            case SettingsSectionType.ADDKIDS:
//                let vc = CreateKidViewController.instantiate(from: .Settings)
//                self.showDetailViewController(vc, sender: nil)
//
//            default:
//                let vc = UserProfileViewController.instantiate(from: .Settings)
//                self.showDetailViewController(vc, sender: nil)
//        }

    }
  
}
