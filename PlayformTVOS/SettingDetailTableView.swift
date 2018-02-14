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
 * SettingDetailTableView.swift
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/6/21.
 */

import Foundation
import UIKit

class SettingDetailTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    var controller: SettingDetailViewController = SettingDetailViewController()
    fileprivate var viewModel: SettingsDetailViewModelProtocol?
    var myType = SettingsSectionType.USER
    let customRowHeight: CGFloat = 60
    var allCells:[DetailCellUIData] = [DetailCellUIData]()
    var allBlock = [CellBlock]()
    var visibaleCells:[Int ] = [Int]()
    var tempFreezeToFakeFocus: Bool = false
    var myIndexPath = IndexPath(row: 0, section: 0)
    var lastIndexPath = IndexPath(row: 0, section: 0)
    enum InputType: Int {
        case TextWithArrowCell
        case TextWithSubTitle
    }
    func initial(controller: SettingDetailViewController, viewModel: SettingsDetailViewModelProtocol?, type: SettingsSectionType) {
        self.delegate = self
        self.dataSource = self
        self.controller = controller
        self.viewModel = viewModel
        self.myType = type
        
        allCells.removeAll()
        setUIData(blocks: getBlocks(type: type))
        getIndicesOfVisibleRows()
        
        self.remembersLastFocusedIndexPath = false
        self.controller.restoresFocusAfterTransition = false

        setNeedsFocusUpdate()
        updateFocusIfNeeded()
    }
    
    func getIndicesOfVisibleRows() {
        visibaleCells.removeAll()
        
        for row in 0...(allCells.count - 1) {
            if allCells[row].isVisible {
                visibaleCells.append(row)
            }
        }
    }
    
    private func getBlocks(type: SettingsSectionType)->[CellBlock] {
        
        var blocks = [CellBlock]()
        switch type {
            
        default:
            let block = getBlockByType(type: type)
            blocks.append(block)
            
        }
        return blocks
    }
    
    private func getBlockByType(type: SettingsSectionType) -> CellBlock{
        let dp = CellDataProducer()
        for block in allBlock {
            if (block.tag == type.rawValue) {
                return block
            }
        }
        let block = dp.GetCellData(type: type )
        allBlock.append(block)
        return block
        
    }
    
    internal func setUIData(blocks:[CellBlock]) {
        allCells = [DetailCellUIData]()
        
        for block in blocks {
            allCells.append(contentsOf: block.cellArray)
        }
    }
    
//    func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath? {
//        return myIndexPath
//    }  
/*
     Since the func preferredFocus only fire once at the view beginning,
     We can not directly change the main subject we want to focus.
     Here is our solution:
     
     Set all the objects CAN NOT be focus EXPECT our target. (canFocusRowAt)
     And we reset all objects focusable when done updating. (didUpdateFocusIn)
*/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndexPath = indexPath
        lastIndexPath = indexPath
    }
    
    func setNextFocusRow() {
        if (lastIndexPath.row + 1 < numberOfRows(inSection: lastIndexPath.section)) {
            myIndexPath.row = lastIndexPath.row + 1
        } else {
            myIndexPath.row = 0
        }
        
        tempFreezeToFakeFocus = true
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        if (tempFreezeToFakeFocus) {
            if (indexPath.row == myIndexPath.row && indexPath.section == myIndexPath.section) {
                return true
            } else {
                return false
            }
        } else {
            return true
        }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        tempFreezeToFakeFocus = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return customRowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellUIData = allCells[visibaleCells[indexPath.row]]
        if let cell: SettingsDetailCellReciever = tableView.dequeueReusableCell(withIdentifier: cellUIData.cellIdentifier, for: indexPath) as? SettingsDetailCellReciever {
            cell.setViewModelData(cellUIData: cellUIData, settingsCellViewModel: viewModel, tableView: self, idx: indexPath.row, type: self.myType)
            if let tempCell: UITableViewCell = cell as? UITableViewCell{
                return tempCell
            } else {
                let cell = UITableViewCell()
                return cell
            }
            
        } else {
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibaleCells.count
    }
    
}
