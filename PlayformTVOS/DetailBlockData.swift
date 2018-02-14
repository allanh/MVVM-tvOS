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
 * DetailBlockData.swift
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/7/5.
 */

import Foundation
import UIKit

class DetailCellUIData: Hashable
{
    var tag = 0
    var index = 0
    var primaryTitle: String
    var cellIdentifier: String
    var block = 0
    var placeHolder: String
    var property: String
    var dataField: String
    var isVisible: Bool
    
    var hashValue: Int {
        return tag.hashValue ^ block.hashValue ^ index
    }
    
    public static func ==(lhs: DetailCellUIData, rhs: DetailCellUIData) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    init(cellIdentifier:String, primaryTitle:String, placeHolder: String = "", property: String = "", dataField: String = "", isVisible: Bool)
    {
        self.cellIdentifier = cellIdentifier
        self.primaryTitle = primaryTitle
        self.property = property
        self.dataField = dataField
        self.placeHolder = placeHolder
        self.isVisible = isVisible
    }
    
    func setBlock(blockTag: Int)
    {
        self.block = blockTag
    }
}

extension CellBlock {
    func getVisibleCellArray() -> [DetailCellUIData] {
        var array: [DetailCellUIData] = []
        for cellData in cellArray {
            array.append(cellData)
        }
        return array
    }
    
    func setCellBlock() {
        for cell in cellArray {
            cell.setBlock(blockTag: tag)
        }
    }
}

protocol CellBlock {
    var tag: Int {get}
    var cellArray: [DetailCellUIData]  {get set}
}

struct UserProfileMenu: CellBlock {
    var tag: Int = 0
    var cellArray = [DetailCellUIData]()
    init() {
        let firstNameCell = DetailCellUIData(cellIdentifier: "TextWithArrowCell", primaryTitle: "First Name", placeHolder: "ex. Ken", dataField: "firstname", isVisible: true)
        cellArray.append(firstNameCell)
        let lastNameCell = DetailCellUIData(cellIdentifier: "TextWithArrowCell", primaryTitle: "Last Name", placeHolder: "ex. Lee", dataField: "lastname", isVisible: true)
        cellArray.append(lastNameCell)
        let genderCell = DetailCellUIData(cellIdentifier: "TextWithSubTitle", primaryTitle: "Gender", property: "adult", dataField: "gender", isVisible: true)
        cellArray.append(genderCell)
        let birthCell = DetailCellUIData(cellIdentifier: "DateEnterCell", primaryTitle: "Birthdate", placeHolder: "ex.", dataField: "birth", isVisible: true)
        cellArray.append(birthCell)
        let privacyCell = DetailCellUIData(cellIdentifier: "ClickAndEnterArrowCell", primaryTitle: "Privacy Statement", property: "PrivacyStatementWebViewController", dataField: "firstname", isVisible: true)
        cellArray.append(privacyCell)

        setCellBlock()
    }
}


struct KidProfileMenu: CellBlock {
    var tag: Int = 1
    var cellArray = [DetailCellUIData]()
    init() {
        let firstNameCell = DetailCellUIData(cellIdentifier: "TextWithArrowCell", primaryTitle: "Nickname", placeHolder: "ex. Kate",  dataField: "nickname", isVisible: true)
        cellArray.append(firstNameCell)
        let genderCell = DetailCellUIData(cellIdentifier: "TextWithSubTitle", primaryTitle: "Gender", property: "kid", dataField: "gender", isVisible: true)
        cellArray.append(genderCell)
        let birthCell = DetailCellUIData(cellIdentifier: "DateEnterCell", primaryTitle: "Birthdate", placeHolder: "ex.", dataField: "birth", isVisible: true)
        cellArray.append(birthCell)
        let privacyCell = DetailCellUIData(cellIdentifier: "ClickAndEnterArrowCell", primaryTitle: "Privacy Statement", property: "PrivacyStatementWebViewController", dataField: "firstname", isVisible: true)
        cellArray.append(privacyCell)
        
        setCellBlock()
    }
}


struct CreateKidProfileMenu: CellBlock {
    var tag: Int = 2
    var cellArray = [DetailCellUIData]()
    init() {
        let firstNameCell = DetailCellUIData(cellIdentifier: "TextWithArrowCell", primaryTitle: "Nickname", placeHolder: "ex. Kate",  dataField: "nickname", isVisible: true)
        cellArray.append(firstNameCell)
        let genderCell = DetailCellUIData(cellIdentifier: "TextWithSubTitle", primaryTitle: "Gender", property: "kid", dataField: "gender", isVisible: false)
        cellArray.append(genderCell)
        let birthCell = DetailCellUIData(cellIdentifier: "DateEnterCell", primaryTitle: "Birthdate", placeHolder: "ex.", dataField: "birth", isVisible: false)
        cellArray.append(birthCell)
        let privacyCell = DetailCellUIData(cellIdentifier: "ClickAndEnterArrowCell", primaryTitle: "Privacy Statement", property: "PrivacyStatementWebViewController", dataField: "firstname", isVisible: true)
        cellArray.append(privacyCell)
        
        setCellBlock()
    }
}

class CellDataProducer
{
    func GetCellData(type: SettingsSectionType) -> CellBlock
    {
        switch type {

        case SettingsSectionType.KIDS:
            return KidProfileMenu()
        case SettingsSectionType.ADDKIDS:
            return CreateKidProfileMenu()
            
        default:
            return UserProfileMenu()

        }
    }
}
