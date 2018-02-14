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
 * PopupInfo.swift
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/7/13.
 */

import Foundation
import UIKit

struct PopupInfo {
    var title: String = ""
    var description: String = ""
    var comfirmButtontext: String = ""
    var cancelButtontext: String = ""
}

enum PopupTitleIndex : String {
    case UNABLE_TO_UPDATE = "unable_To_Update|unable_To_Update_Description|tryAgain|cancel|"
}

class PopupData{
    
    static let shared = PopupData()

    func getPopupInfo(title:PopupTitleIndex) -> PopupInfo {
        
        var popupInfo = PopupInfo()
        
        let array = title.rawValue.components(separatedBy: "|")
        if array.count < 4 {
            print("component error")
            return popupInfo
        }
        popupInfo.title = NSLocalizedString(array[0], comment: "")
        popupInfo.description = NSLocalizedString(array[1], comment: "")
        popupInfo.comfirmButtontext = NSLocalizedString(array[2], comment: "")
        popupInfo.cancelButtontext = NSLocalizedString(array[3], comment: "")

        return popupInfo
    }

}
