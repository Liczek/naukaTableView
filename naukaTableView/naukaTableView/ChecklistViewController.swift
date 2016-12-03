//
//  ChecklistViewController.swift
//  naukaTableView
//
//  Created by Paweł Liczmański on 22.11.2016.
//  Copyright © 2016 Paweł Liczmański. All rights reserved.
//

import Foundation
import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
    
    var items: [ChecklistItem]
    
    required init?(coder aDecoder: NSCoder) {
        
        items = [ChecklistItem]()
        
        super.init(coder: aDecoder)
        loadChecklisteItem()
        print("\(documentDirectory())")
    }
    
//MARK: TableView Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItemCell", for: indexPath)
        let item = items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
            item.toggleCheckmark()
            configureCheckmark(for: cell, with: item)
            saveChecklistItem()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
    }
    
    
    
//MARK: Random methods
    
    func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "✅"
        } else {
            label.text = "☑️"
        }

    }
    
    func configureText(for cell: UITableViewCell, with item: ChecklistItem){
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
//MARK: Save and Load Data
    
    func saveChecklistItem() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(items, forKey: "ChecklistItems")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
    
    func loadChecklisteItem() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            items = unarchiver.decodeObject(forKey: "ChecklistItems") as! [ChecklistItem]
            unarchiver.finishDecoding()
        }
    }
    
//MARK: Delegates and segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddItemViewController
            controller.delegate = self
            
        } else if segue.identifier == "EditItem" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AddItemViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
            controller.itemToEdit = items[indexPath.row]
                
            }
        }
    }
    
    func addItemViewControllerCancel(_ controller: AddItemViewController) {
        dismiss(animated: true, completion: nil)
        saveChecklistItem()
    }
    
    func addItemViewController(_ controller2: AddItemViewController, didFinishAdding item: ChecklistItem) {
        let newItemIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newItemIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
        saveChecklistItem()
    }
    
    func addItemViewController(_ controller2: AddItemViewController, didFinishEditing item: ChecklistItem) {
        if let index = items.index(of: item){
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
            dismiss(animated: true, completion: nil)
            saveChecklistItem()
        }
        
    }
    
//MARK: Data Directories
    
    func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentDirectory().appendingPathComponent("Checklist.plist")
    }
    
    
}
