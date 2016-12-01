//
//  ChecklistItem.swift
//  naukaTableView
//
//  Created by Paweł Liczmański on 01.12.2016.
//  Copyright © 2016 Paweł Liczmański. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    var text = ""
    var checked = false
    
    func toggleCheckmark() {
        checked = !checked
    }
}
