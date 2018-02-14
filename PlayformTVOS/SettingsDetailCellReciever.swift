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
 * SettingsDetailCellReciever.swift
 * PlayformTVOSTests
 *
 * Created by sue.liu on 2017/6/26.
 */

import Foundation
import UIKit

protocol SettingsDetailCellReciever {
    func setViewModelData(cellUIData: DetailCellUIData, settingsCellViewModel: SettingsDetailViewModelProtocol?, tableView:SettingDetailTableView, idx: Int, type: SettingsSectionType)
}

extension SettingsDetailCellReciever
{
    func setViewModelData(cellUIData: DetailCellUIData, settingsCellViewModel: SettingsDetailViewModelProtocol?, tableView:SettingDetailTableView, idx: Int, type: SettingsSectionType) {
    }
}
