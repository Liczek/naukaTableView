//
//  ViewController.swift
//  naukaTableView
//
//  Created by Paweł Liczmański on 13.11.2016.
//  Copyright © 2016 Paweł Liczmański. All rights reserved.
//

import UIKit

class ListaZadanViewControler: UITableViewController {
    
    var zadania = [Zadanie]()
    
    required init?(coder aDecoder: NSCoder) {
        
        let zadanie1 = Zadanie()
        zadanie1.text = "Pierwsze zadanie"
        zadanie1.checked = true
        zadania.append(zadanie1)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

