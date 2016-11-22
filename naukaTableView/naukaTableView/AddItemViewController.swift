//
//  AddItemViewController.swift
//  naukaTableView
//
//  Created by Paweł Liczmański on 22.11.2016.
//  Copyright © 2016 Paweł Liczmański. All rights reserved.
//

import Foundation
import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerCancel(_ controller2: AddItemViewController)
    func addItemViewController(_ controller2: AddItemViewController, didFinishAdding item: ChecklistItem)
    func addItemViewController(_ controller2: AddItemViewController, didFinishEditing item: ChecklistItem)
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
            doneBarButton.isEnabled = true
            textField.text = item.text
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textField.becomeFirstResponder()
        textField.placeholder = "Enter new item name"
        doneBarButton.isEnabled = false
        
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
    
    @IBAction func cancel() {
        delegate?.addItemViewControllerCancel(self)
        
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newtext = oldText.replacingCharacters(in: range, with: string) as NSString
        
        doneBarButton.isEnabled = newtext.length > 0
        return true
    }
    
    
}
