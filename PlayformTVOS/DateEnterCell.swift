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
 * DateEnterCell.swift
 * PlayformTVOSTests
 *
 * Created by sue.liu on 2017/6/26.
 */

import Foundation
import UIKit

class DateEnterCell: CustomInputCell, SettingsDetailCellReciever, UITextFieldDelegate {
    @IBOutlet weak var mainTitleLbl: UILabel!
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var arrowImg: UIImageView!
    
    var viewModel: SettingsDetailViewModelProtocol?

    var myTableView: SettingDetailTableView?
    var type: SettingsSectionType?
    var cellUIData: DetailCellUIData?
    var myDateEnterPhase: DateEnterPhase?
    fileprivate var myCustomInputAccessoryView: CustomInputAccessoryView?
    var day: Int = 28
    var month: Int = 12
    var year: Int = 1984
    
    var dateFromModel: String = ""
    var isEditInit: Bool = false
    var isLockBeforeComplete: Bool = false
    /*
        There is a weird issue and a solution.
        Click [menu] will fire textFieldShouldEndEditing,
        In the meanwhile, Click [done] will fire both textFieldShouldEndEditing and textFieldShouldReturn.
        We can not seperate those two button event apart,
        so we use isLockBeforeComplete to avoid edit end when click [done] but not yet complete the data.
     */
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        if (isEditInit == false) {
            textField.text = string.trimmingCharacters(in: .whitespacesAndNewlines)
            isEditInit = true
        }

        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= myDateEnterPhase?.limitLength ?? 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (inputEnd()) {
            viewModel?.udpateDataModel(dataField: cellUIData?.dataField ?? "" , dateDay: self.day, dateMonth: self.month, dateYear: self.year)
            isLockBeforeComplete = false
            return true
        } else {
            isLockBeforeComplete = true
            return false
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if  (isLockBeforeComplete == false) {
            isEditInit = false
            return true
        } else {
            isLockBeforeComplete = false
            return false
        }
    }
    
    func checkDateAvaliable() -> DateCheckResult {
        let result = myDateEnterPhase?.checkDateAvaliable(intYear: self.year, intMonth: self.month, intDay: self.day, intNew: parseDateStrToInt(strDate: myTextField.text ?? "0"))
        return result ?? .InValid
    }
    
    func inputEnd() -> Bool {
        
        if(canEnterNextPhase()) {
            if (self.myDateEnterPhase?.inputEnd == true) {
                return true
            }else {
                setNextEnterPhase()
            }
        }
        return false
    }
    
    func canEnterNextPhase() -> Bool {
        if (myTextField.text != "" && myTextField.text?.contains(" ") == false) {
            let dateCheckResult = checkDateAvaliable()
            if (dateCheckResult == .Valid) {
                if(self.myDateEnterPhase?.type == SettingConstant.DateType.YEAR) {
                    self.year = parseDateStrToInt(strDate: myTextField.text ?? "1")
                } else if (self.myDateEnterPhase?.type == SettingConstant.DateType.MONTH) {
                    self.month = parseDateStrToInt(strDate: myTextField.text ?? "1")
                } else {
                    self.day = parseDateStrToInt(strDate: myTextField.text ?? "1")
                }
                return true
            } else {
                myCustomInputAccessoryView?.setMessage(NSLocalizedString(self.myDateEnterPhase?.warnStr ?? "", comment: ""), level: .Warning, interfaceStyle: getUserInterfaceStyle())
                return false
            }
        }
        return false
    }
    
    func parseDateStrToInt(strDate: String) -> Int {
        guard let newInt = Int(strDate) else {
            return 1
        }
        return newInt
    }
    
    func setNextEnterPhase() {
        isEditInit = false
        setState(phase: myDateEnterPhase?.nextPhase() ?? YearPhase())
    }
    
    func setState(phase : DateEnterPhase){
        self.myDateEnterPhase = phase
        myDateEnterPhase?.enterPhase()

        self.myCustomInputAccessoryView?.changeTitle(title: cellUIData?.primaryTitle ?? "")
        let hintIndex = self.myDateEnterPhase?.type.description ?? ""
        self.myCustomInputAccessoryView?.setMessage(NSLocalizedString( hintIndex + "_hint", comment: ""), level: .Normal, interfaceStyle: getUserInterfaceStyle())
        
        let hintPhase = self.myDateEnterPhase?.type.description ?? ""
        let hintPlaceholder = self.cellUIData?.placeHolder ?? ""
        let hintDate = String(self.myDateEnterPhase?.exDate ?? 0)
        myTextField.text = hintPhase + " " + hintPlaceholder + " " + hintDate
    }

    func setDateFromData(data: String) {
        print(data)
        let dateArray = data.components(separatedBy: "/")
        for index in 0...dateArray.count - 1
        {
            if(index == 0) {
                guard let yearInt = Int(dateArray[index]) else {
                    setTitleNull()
                    return
                }
                year = yearInt
            } else if (index == 1) {
                guard let monthInt = Int(dateArray[index]) else {
                    setTitleNull()
                    return
                }
                month = monthInt
            } else {
                guard let dayInt = Int(dateArray[index]) else {
                    setTitleNull()
                    return
                }
                day = dayInt
            }
        }
        if(year != 0 && month != 0 && day != 0) {
            mainTitleLbl.text = "\(year)/\(month)/\(day)"
        } else {
            setTitleNull()
        }
    }
    
    func setTitleNull() {
        mainTitleLbl.text = self.cellUIData?.primaryTitle
    }
    
    func setViewModelData(cellUIData: DetailCellUIData, settingsCellViewModel: SettingsDetailViewModelProtocol?, tableView:SettingDetailTableView, idx: Int, type: SettingsSectionType){
        self.myTableView = tableView
        self.type = type
        self.cellUIData = cellUIData
        self.viewModel = settingsCellViewModel
        self.dateFromModel = viewModel?.getDataAndFillMenu(dataField: cellUIData.dataField) ?? ""
        setDateFromData(data: dateFromModel)
        self.myCustomInputAccessoryView = CustomInputAccessoryView(title: self.myDateEnterPhase?.type.description ?? "")
        myTextField.inputAccessoryView = self.myCustomInputAccessoryView
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        myTextField.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if (selected) {
            setState(phase: YearPhase())
            myTextField.becomeFirstResponder()
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
