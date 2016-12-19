//
//  AllListsViewController.swift
//  naukaTableView
//
//  Created by Paweł Liczmański on 19.12.2016.
//  Copyright © 2016 Paweł Liczmański. All rights reserved.
//

import Foundation
import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate {
    
    var dataModel: DataModel!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Do To List"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = makeCell(for: tableView)
        let checklist = dataModel.lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    func makeCell(for tableView: UITableView) -> UITableViewCell {
        let cellIdentifier = "CellLists"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier){
        return cell
        } else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            return cell
        }
    }
/////////////////////////////////////////////////////////////////////////////////////
    
//MARK: >>>>> ZAGADKA <<<<<
    //Jak sprawić, żeby pojawiający się ChecklistViewController posiadał NavigationController odziedziczony po AllListsViewController? (Nie patrz na segue w storyboard to jest pozostałość po poprzedniej wersji czyli po rpzejściu poprzez performsegue - tam wszystko działało bo był "Show")
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "ListVC") as! ChecklistViewController
        let checklist = dataModel.lists[indexPath.row]
        controller.checklist = checklist
        present(controller, animated: true, completion: nil)
        //performSegue(withIdentifier: "ShowList", sender: checklist)
        tableView.deselectRow(at: indexPath, animated: true)
    }
/////////////////////////////////////////////////////////////////////////////////////

    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let checklist = dataModel.lists[indexPath.row]
        performSegue(withIdentifier: "EditList", sender: checklist)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataModel.lists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
//MARK: Delegates
    
    func listDetailViewControllerCancel(_ controller: ListDetailViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAdding checklist: Checklist) {
        let index = dataModel.lists.count
        dataModel.lists.append(checklist)
        let indexPath = IndexPath(row: index, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditing checklist: Checklist) {
        if let index = dataModel.lists.index(of: checklist){
        let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath){
                cell.textLabel!.text = checklist.name
            }
            dismiss(animated: true, completion: nil)
        }
    }
    
//MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddList" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ListDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditList" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ListDetailViewController
            controller.delegate = self
            controller.listToEdit = sender as! Checklist}
//        } else if segue.identifier == "ShowList" {
//            let controller = segue.destination as! ChecklistViewController
//            controller.checklist = sender as! Checklist           
//        }
    }
}
