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
 * ClickAndEnterArrowCell.swift
 * PlayformTVOSTests
 *
 * Created by sue.liu on 2017/6/26.
 */

import Foundation
import UIKit

class ClickAndEnterArrowCell: CustomInputCell, SettingsDetailCellReciever {
    var myTableView: SettingDetailTableView?
    var type: SettingsSectionType?
    var cellUIData: DetailCellUIData?
    
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var mainTitleLbl: UILabel!
    func setViewModelData(cellUIData: DetailCellUIData, settingsCellViewModel: SettingsDetailViewModelProtocol?, tableView:SettingDetailTableView, idx: Int, type: SettingsSectionType){
        self.myTableView = tableView
        self.type = type
        self.cellUIData = cellUIData
        self.mainTitleLbl.text = cellUIData.primaryTitle
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if (selected) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: cellUIData?.property ?? ""), object: nil)
        }
    }
    
    override func setFont(color: UIColor) {
        mainTitleLbl.textColor = color
    }
    
    override func setFocusUI(isDark: Bool) {
        super.setFocusUI(isDark: isDark)
        if(isDark) {
            arrowImg.image = UIImage(named: "btn_graph_next_disable")
        }
    }
    
    override func resetUI(isDark: Bool) {
        super.resetUI(isDark: isDark)
        if(isDark) {
            arrowImg.image = UIImage(named: "btn_header_back")
        }
        
    }
}
