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
 * SettingsDetailViewModel.swift
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/7/11.
 */

import Foundation
import PlayformSDK_TV


protocol SettingsDetailViewModelProtocol {
    var isFakeData: Bool { get set }
    init(type: SettingsSectionType, index: Int, profile: UserProfile?, kidProfile: KidAccountPresentable?)
    func getDataAndFillMenu(dataField: String) -> String
    func udpateDataModel(dataField: String, data: String)
    func udpateDataModel(dataField: String, dateDay: Int, dateMonth: Int, dateYear: Int)
    func checkFieldInputValid(dataField: String, data: String) -> String
    func viewModelGenderToUIGender(data: String) -> String
    func uIGenderToViewModelGemder(data: String) -> String
    func getUserAccountStr() -> String
    func isCreateKid() -> Bool
    func sendDataAgain()
}

class SettingsDetailViewModel: SettingsDetailViewModelProtocol {
    var isFakeData: Bool = true
    weak var mySettingsManager: SettingsManager?
    var userProfile: UserProfile?
    var kidProfile: KidAccountPresentable?
    var kid: PlayformSDK_TV.KidProfile = PlayformSDK_TV.KidProfile()
    var type: SettingsSectionType?
    var viewModel: SettingsViewModelProtocol?
    var isCreatingKid: Bool = false

    func getUserAccountStr() -> String {
        return self.userProfile?.emails?.find({$0.isPrimary == true})?.email ?? ""
    }
    
    func sendDataAgain() {
        if(type == SettingsSectionType.USER) {
            saveUser()
        } else if (type == SettingsSectionType.KIDS) {
            saveUpdateKid()
        } else {
            saveCreatedKid()
        }
    }

    required convenience init(type: SettingsSectionType, index: Int, profile: UserProfile?, kidProfile: KidAccountPresentable?) {
        self.init()
        self.userProfile = profile
        self.kidProfile = kidProfile
        self.type = type
    }
    
    func viewModelGenderToUIGender(data: String) -> String {
        if (type == SettingsSectionType.USER) {
            if(data == SettingConstant.Gender.FEMALE.rawValue) {
                return SettingConstant.GenderOption.FEMALE.rawValue
            } else if (data == SettingConstant.Gender.MALE.rawValue){
                return SettingConstant.GenderOption.MALE.rawValue
            } else {
                return SettingConstant.Gender.NONE.rawValue
            }
        } else {
            if(data == SettingConstant.Gender.FEMALE.rawValue) {
                return SettingConstant.KidGenderOption.GIRL.rawValue
            } else if (data == SettingConstant.Gender.MALE.rawValue) {
                return SettingConstant.KidGenderOption.Boy.rawValue
            } else {
                return SettingConstant.Gender.NONE.rawValue
            }
        }
    }
    func uIGenderToViewModelGemder(data: String) -> String {
        if (type == SettingsSectionType.USER) {
            if(data == SettingConstant.GenderOption.FEMALE.rawValue) {
                return SettingConstant.Gender.FEMALE.rawValue
            } else {
                return SettingConstant.Gender.MALE.rawValue
            }
        } else {
            if(data == SettingConstant.KidGenderOption.GIRL.rawValue) {
                return SettingConstant.Gender.FEMALE.rawValue
            } else {
                return SettingConstant.Gender.MALE.rawValue
            }
        }
    }
    
    func checkFieldInputValid(dataField: String, data: String) -> String {
        var hint = ""
        switch (dataField) {
            case SettingConstant.DataField.NickName.rawValue:
                if(data != self.kidProfile?.kidNickName) {
                    if (viewModel?.getKidsAccounts().contains(where: { $0.kidNickName == data }) == true) {
                        hint = String.localizedStringWithFormat(NSLocalizedString("wrong_nickName", comment: data), data)
                    }
                }
            
            default:
                break
        }
        return hint
    }
    
    func getDataAndFillMenu(dataField: String) -> String {
        var data = dataField
        switch (dataField) {

            case SettingConstant.DataField.FirstName.rawValue:
                if (type == SettingsSectionType.USER) {
                    data = self.userProfile?.firstName ?? ""
                }
            case SettingConstant.DataField.LastName.rawValue:
                if (type == SettingsSectionType.USER) {
                    data = self.userProfile?.lastName ?? ""
                }
            case SettingConstant.DataField.NickName.rawValue:
                if (type == SettingsSectionType.USER) {
                    data = self.userProfile?.nickName ?? ""
                } else {
                    data = self.kidProfile?.kidNickName ?? ""
                }
            case SettingConstant.DataField.Birth.rawValue:
            
                var dayStr: String = ""
                var monthStr: String = ""
                var yearStr: String = ""
            
                if (type == SettingsSectionType.USER) {
                    if let d = self.userProfile?.dayOfBirth {
                        dayStr = "\(d)"
                    }
                    if let m = self.userProfile?.monthOfBirth {
                        monthStr = "\(m)"
                    }
                    if let y = self.userProfile?.yearOfBirth {
                        yearStr = "\(y)"
                    }
                    data = yearStr + "/" + monthStr + "/" + dayStr
                } else {
                    if let d = self.kidProfile?.kidDayOfBirth {
                        dayStr = "\(d)"
                    }
                    if let m = self.kidProfile?.kidMonthOfBirth {
                        monthStr = "\(m)"
                    }
                    if let y = self.kidProfile?.kidYearOfBirth {
                        yearStr = "\(y)"
                    }
                    data = yearStr + "/" + monthStr + "/" + dayStr
                }
            
            case SettingConstant.DataField.Gender.rawValue:
                if (type == SettingsSectionType.USER) {
                    data = viewModelGenderToUIGender(data: self.userProfile?.gender ?? SettingConstant.Gender.NONE.rawValue)
                } else {
                    data = viewModelGenderToUIGender(data: self.kidProfile?.kidGender ?? SettingConstant.Gender.NONE.rawValue)
                }

            default:
                break
        }
        return data
    }
    
    private func saveUser() {
        viewModel?.setUserProfile(self.userProfile)
        viewModel?.save(onSuccess: {
        print("saveUser success")
        self.SucessSaved()

        }, onError: { (Error) in
        self.ErrorOnSave()
        })
    }
    
    private func saveUpdateKid() {
        self.kidProfile?.updateKidAccount(onSuccess: { (KidAccount) in
            print("saveUpdateKid success")
            self.SucessSaved()
        }, onError: { (Error) in
            print("saveUpdateKid wrong")
            self.ErrorOnSave()
        })
    }
    
    func saveCreatedKid() {
        // update server
//        if (viewModel?.isFakeData == false) {
            self.kidProfile?.createKidAccount(onSuccess: { (KidAccount) in
                self.sucessCreateKid(kidAccount: KidAccount)
            }, onError: { (Error) in
                self.errorOnCreateKid()
            })
//        }
//        else {
//            if var kids: [KidAccount] = self.viewModel?.getKidsAccounts() as? [KidAccount] {
//                kids.append(self.kidProfile?.kidAccount ?? KidAccount())
//                self.viewModel?.setKidAccounts(kids)
//            }            
//            self.type = SettingsSectionType.KIDS
//        }
    }

    func updateUser(dataField: String, data: String) {
        
        switch (dataField) {
        case SettingConstant.DataField.FirstName.rawValue:
            self.userProfile?.firstName = data
        case SettingConstant.DataField.LastName.rawValue:
            self.userProfile?.lastName = data
        case SettingConstant.DataField.NickName.rawValue:
            self.userProfile?.nickName = data
        case SettingConstant.DataField.Gender.rawValue:
            self.userProfile?.gender = data
            
        default:
            break
        }
        saveUser()
    }

    func updateKid(dataField: String, data: String) {
        switch (dataField) {
            case SettingConstant.DataField.NickName.rawValue:
                self.kidProfile?.kidNickName = data
            case SettingConstant.DataField.Gender.rawValue:
                self.kidProfile?.kidGender = data
                    
            default:
                break
        }
        saveUpdateKid()
    }
    
    func createKid(dataField: String, data: String) {
        switch (dataField) {
        case SettingConstant.DataField.NickName.rawValue:
            self.kidProfile?.kidNickName = data
        case SettingConstant.DataField.Gender.rawValue:
            self.kidProfile?.kidGender = data
            
        default:
            break
        }

        if (KidAccountExist() == false) {
            saveCreatedKid()
        } else {
            updateKid(dataField: dataField, data: data)
        }
    }
    
    fileprivate func KidAccountExist() -> Bool {
        if (viewModel?.getKidsAccounts().contains(where: { $0.kidNickName == self.kidProfile?.kidNickName }) == true) {
            return true
        }
        return false
    }

    func udpateDataModel(dataField: String, data: String) {
        
        if (type == SettingsSectionType.USER) {
            updateUser(dataField: dataField, data: data)
            isCreatingKid = false
        } else if (type == SettingsSectionType.KIDS) {
            updateKid(dataField: dataField, data: data)
            isCreatingKid = false
        } else {
            createKid(dataField: dataField, data: data)
            isCreatingKid = true
        }
    }
    
    func isCreateKid () -> Bool {  //TODO: find some advanced way....
        return isCreatingKid
    }
    
    func udpateDataModel(dataField: String, dateDay: Int, dateMonth: Int, dateYear: Int) {
        // if type == USER : save after update
        if (type == SettingsSectionType.USER) {
            self.userProfile?.dayOfBirth = dateDay
            self.userProfile?.monthOfBirth = dateMonth
            self.userProfile?.yearOfBirth = dateYear
            
            saveUser()
        // if type == KIDS or ADDKIDS : save after update
        } else {
            self.kidProfile?.kidDayOfBirth = dateDay
            self.kidProfile?.kidMonthOfBirth = dateMonth
            self.kidProfile?.kidYearOfBirth = dateYear
            
            saveUpdateKid()
        }
    }

    func sucessCreateKid(kidAccount: KidAccount){
        print("successCreateKid")
        let kidProfile: KidAccountPresentable = MyKidAccount(kidAccount: kidAccount)
        self.kidProfile = kidProfile
        if var kids: [KidAccount] = self.viewModel?.getKidsAccounts() as? [KidAccount] {
            kids.append(kidAccount)
            self.viewModel?.setKidAccounts(kids)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SettingConstant.Notification.CREATE_KID_SUCCESS), object: nil)
    
        self.type = SettingsSectionType.KIDS
    }

    func errorOnCreateKid(){
        print("errorOnCreateKid.")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SettingConstant.Notification.UNABLE_TO_ADD_KIDS), object: nil)
    }
    
    func SucessSaved(){
        print("SucessSaved viewmodel.")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SettingConstant.Notification.UPDATE_INFORM_SUCCESS), object: nil)
    }
    func ErrorOnSave(){
        print("save viewmodel Error.")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SettingConstant.Notification.UNABLE_TO_UPDATE_INFORM), object: nil)
    }
    
}
