//
//  AddItemViewController.swift
//  naukaTableView
//
//  Created by Paweł Liczmański on 17.11.2016.
//  Copyright © 2016 Paweł Liczmański. All rights reserved.
//

import Foundation
import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAdding item: ChecklistItem)
}
class AddItemViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: AddItemViewControllerDelegate?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textField.becomeFirstResponder()
        textField.enablesReturnKeyAutomatically = true
        textField.returnKeyType = .done
        doneBarButton.isEnabled = false
        
    }
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    @IBAction func done() {
        print("done")
        let item = ChecklistItem()
        item.text = textField.text!
        item.checked = true
        delegate?.addItemViewController(self, didFinishAdding: item)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        print("cencel")
        delegate?.addItemViewControllerCancel(self)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        doneBarButton.isEnabled = newText.length > 0
        return true
    }
    
   
    
    
}
