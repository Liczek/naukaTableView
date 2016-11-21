//
//  ChecklistItem.swift
//  naukaTableView
//
//  Created by Paweł Liczmański on 14.11.2016.
//  Copyright © 2016 Paweł Liczmański. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
