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
 * UserProfileTableView.swift * PlayformTVOS
 *
 * Created by sue.liu on 2017/6/21.
 */

import Foundation
import UIKit

class UserProfileTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let type: SettingsSectionType = SettingsSectionType(rawValue: indexPath.section) {
            return getCellbyType(type: type, idx: indexPath.row)
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func getCellbyType(type: SettingsSectionType, idx: Int) -> UITableViewCell {
        var cellName: String = ""
        switch (type) {
        default:
            cellName = "TextWithArrow"
        }
        
        if let cell = self.dequeueReusableCell(withIdentifier: cellName) as? SettingsCellReciever {
            
            if let tempCell: UITableViewCell = cell as? UITableViewCell{
                return tempCell
            }else{
                return UITableViewCell()
            }
            
        } else{
            return UITableViewCell()
        }
    }
}
