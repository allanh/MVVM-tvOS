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
 * TextWithSubTitle.swift
 * PlayformTVOSTests
 *
 * Created by sue.liu on 2017/6/26.
 */

import Foundation
import UIKit

class TextWithSubTitle: CustomInputCell, SettingsDetailCellReciever, UITextFieldDelegate {
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    var myTableView: SettingDetailTableView?
    var type: SettingsSectionType?
    var cellUIData: DetailCellUIData?
    var viewModel: SettingsDetailViewModelProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func editEnd(_ sender: UITextField) {
//        subTitle.text = sender.text
//        myTableView?.setNextFocusRow(indexPath: self.indexPath ?? IndexPath())
//        viewModel?.saveData(dataField: cellUIData?.dataField ?? "" , data: sender.text ?? "")
    }
    
    func setViewModelData(cellUIData: DetailCellUIData, settingsCellViewModel: SettingsDetailViewModelProtocol?, tableView:SettingDetailTableView, idx: Int, type: SettingsSectionType){
        self.myTableView = tableView
        self.type = type
        self.cellUIData = cellUIData
        self.viewModel = settingsCellViewModel
        mainTitle.text = cellUIData.primaryTitle
        subTitle.text = viewModel?.getDataAndFillMenu(dataField: cellUIData.dataField)
    }
    
    func SwitchOption() {
        var newValue: String = ""
        if let propStr = cellUIData?.property {
            if (propStr == SettingConstant.DetailBlock.KID) {
                if(subTitle.text != SettingConstant.KidGenderOption.Boy.rawValue) {
                    newValue = SettingConstant.KidGenderOption.Boy.rawValue
                } else {
                    newValue = SettingConstant.KidGenderOption.GIRL.rawValue
                 }
            } else {
                if(subTitle.text != SettingConstant.GenderOption.MALE.rawValue) {
                    newValue = SettingConstant.GenderOption.MALE.rawValue
                } else {
                    newValue = SettingConstant.GenderOption.FEMALE.rawValue
                }
            }
            viewModel?.udpateDataModel(dataField: cellUIData?.dataField ?? "" , data: viewModel?.uIGenderToViewModelGemder(data: newValue) ?? "")
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if (selected) {
            SwitchOption()
        }
    }
    
    override func setFont(color: UIColor) {
        mainTitle.textColor = color
        subTitle.textColor = color
    }

}
