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
 * UITableViewCell+Index
 * PlayformTVOS
 *
 * Created by sue.liu on 2017/7/5.
 */
import Foundation
import UIKit

extension UITableViewCell {
    
    var indexPath: IndexPath? {
        
        if let table = superview?.superview as? UITableView
        {
            
            return table.indexPath(for: self)
        }
        return nil
    }
}
