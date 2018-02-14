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
 * SettingsCellReciever.swift
 * PlayformTVOSTests
 *
 * Created by sue.liu on 2017/6/26.
 */

import Foundation
import UIKit

protocol SettingsCellReciever {
    func setViewModelData(settingsCellViewModel: SettingsViewModelProtocol?, tableView:SettingsTableView, idx: Int, type: SettingsSectionType)
}

extension SettingsCellReciever
{
    func setViewModelData(settingsCellViewModel: SettingsViewModelProtocol?, tableView:SettingsTableView, idx: Int, type: SettingsSectionType) {
    }
}
