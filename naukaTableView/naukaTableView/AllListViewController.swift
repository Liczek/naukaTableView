//
//  AllListViewController.swift
//  naukaTableView
//
//  Created by Paweł Liczmański on 29.12.2016.
//  Copyright © 2016 Paweł Liczmański. All rights reserved.
//

import Foundation
import UIKit

class AllListViewController: UITableViewController {
    
    let lists = [Checklist]()

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeCell(for: tableView)
        let checklist = lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        return cell
    }
    
    func makeCell(for: UITableView) -> UITableViewCell {
        let cellIdentifier = "CellList"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier){
        return cell
        } else {
        return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "Checklist") as! ChecklistViewController
        let checklist = lists[indexPath.row]
        controller.checklist = checklist
        navigationController?.pushViewController(controller, animated: true)
        present(controller, animated: true, completion: nil)
        performSegue(withIdentifier: "ShowList", sender: checklist)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowList" {
            
        }
    }
}
