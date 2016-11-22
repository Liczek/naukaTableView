//
//  ChecklistItem.swift
//  naukaTableView
//
//  Created by Paweł Liczmański on 22.11.2016.
//  Copyright © 2016 Paweł Liczmański. All rights reserved.
//

import Foundation


class ChecklistItem: NSObject {
    var text = ""
    var checked =  true
    
    func toggleCheckmark() {
        checked = !checked
    }
}
