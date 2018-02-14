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
 * TextWithArrowCell.swift
 * PlayformTVOSTests
 *
 * Created by sue.liu on 2017/6/26.
 */

import Foundation
import UIKit

class TextWithArrowCell: CustomInputCell, SettingsDetailCellReciever, UITextFieldDelegate {
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var arrowImg: UIImageView!
    var myTableView: SettingDetailTableView?
    var type: SettingsSectionType?
    var cellUIData: DetailCellUIData?
    var viewModel: SettingsDetailViewModelProtocol?
    fileprivate var myCustomInputAccessoryView: CustomInputAccessoryView?
    var isEditInit: Bool = false
    var isLockBeforeComplete: Bool = false
    
    /* 
        There is a weird issue and a solution.
        Click [menu] will fire textFieldShouldEndEditing,
        In the meanwhile, Click [done] will fire both textFieldShouldEndEditing and textFieldShouldReturn.
        We can not seperate those two button event apart,
        so we use isLockBeforeComplete to avoid edit end when click [done] but not yet complete the data.
    */
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if  (isLockBeforeComplete == false) {
            return true
        } else {
            isLockBeforeComplete = false
            return false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField.text == "" || textField.text == self.cellUIData?.placeHolder) {
            isLockBeforeComplete = true
            return false
        }
        let message = viewModel?.checkFieldInputValid(dataField: self.cellUIData?.dataField ?? "" , data: textField.text ?? "")
        if (message == "") {
            viewModel?.udpateDataModel(dataField: cellUIData?.dataField ?? "" , data: textField.text ?? "")
            isLockBeforeComplete = false
            return true
        } else {
            myCustomInputAccessoryView?.setMessage(message, level: .Warning, interfaceStyle: getUserInterfaceStyle())
            isLockBeforeComplete = true
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        myTextField.text = self.cellUIData?.placeHolder
        isEditInit = false
        if (viewModel?.isCreateKid() == true && viewModel?.isFakeData == false) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: SettingConstant.Notification.SHOW_CREATE_KID_INDICATOR), object: nil)
        }
    }
    @IBAction func editChanged(_ sender: UITextField) {
        if (isEditInit == false) {
            if let endIdx: String.Index =  sender.text?.endIndex {
                if let newIdx: String.Index = sender.text?.index(before: endIdx) {
                    sender.text = sender.text?.substring(from: newIdx)
                }
            }
            isEditInit = true
        }
    }
    
    func setViewModelData(cellUIData: DetailCellUIData, settingsCellViewModel: SettingsDetailViewModelProtocol?, tableView:SettingDetailTableView, idx: Int, type: SettingsSectionType){
        self.myTableView = tableView
        self.type = type
        self.cellUIData = cellUIData
        self.viewModel = settingsCellViewModel
        let mainTitleStr = viewModel?.getDataAndFillMenu(dataField: cellUIData.dataField)
        myTextField.text = self.cellUIData?.placeHolder
        if (mainTitleStr == "" ){
            mainTitle.text = self.cellUIData?.primaryTitle
        } else {
            mainTitle.text = mainTitleStr
            myTextField.text = mainTitleStr
        }
        myCustomInputAccessoryView = CustomInputAccessoryView(title: cellUIData.primaryTitle)
        myTextField.inputAccessoryView = myCustomInputAccessoryView
        let strIdx = (self.cellUIData?.dataField ?? "") + "_hint"
        myCustomInputAccessoryView?.setMessage(NSLocalizedString(strIdx, comment: ""), level: .Normal, interfaceStyle: getUserInterfaceStyle())

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myTextField.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if (selected) {
            myTextField.becomeFirstResponder()
            let mainTitleStr = viewModel?.getDataAndFillMenu(dataField: cellUIData?.dataField ?? "")
            if (mainTitleStr != "" ){
                myTextField.text = mainTitleStr
            }
        }
    }
    
    override func setFont(color: UIColor) {
       mainTitle.textColor = color
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
