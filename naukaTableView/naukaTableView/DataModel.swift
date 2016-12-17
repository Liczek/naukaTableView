//
//  DataModel.swift
//  naukaTableView
//
//  Created by Paweł Liczmański on 17.12.2016.
//  Copyright © 2016 Paweł Liczmański. All rights reserved.
//

import Foundation

class DataModel {
    
    var lists = [Checklist]()
    
    init() {
        loadChecklists()
    }
    
//MARK: Document Directory and Path
    
    func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentDirectory().appendingPathComponent("Checklist.plist")
    }
    
//MARK: Save and Load Checklists
    
    func saveChecklists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(lists, forKey: "Checklists")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
    
    func loadChecklists() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            lists = unarchiver.decodeObject(forKey: "Checklists") as! [Checklist]
            unarchiver.finishDecoding()
        }
    }

}
