//
//  AddItemViewController.swift
//  naukaTableView
//
//  Created by Paweł Liczmański on 18.11.2016.
//  Copyright © 2016 Paweł Liczmański. All rights reserved.
//

import Foundation
import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerCancel(_ controller: UITableViewController)
    func addItemViewController(_ controller: UITableViewController, didFinishAdding item: ChecklistItem)
    func addItemViewController(_ controller: UITableViewController, didFinishEditing item: ChecklistItem)
}

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: AddItemViewControllerDelegate?
    
    var itemToEdit: ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textField.becomeFirstResponder()
        textField.enablesReturnKeyAutomatically = true
        textField.returnKeyType = .done
        doneBarButton.isEnabled = false
        
    }
    
    @IBAction func cancel() {
        delegate?.addItemViewControllerCancel(self)
        
    }
    
    @IBAction func done() {
        
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.addItemViewController(self, didFinishEditing: item)
        } else {
        
        let item = ChecklistItem()
        item.text = textField.text!
        item.checked = true
            delegate?.addItemViewController(self, didFinishAdding: item)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        
        doneBarButton.isEnabled = newText.length > 0
        
        return true
    }
    
    
    
}