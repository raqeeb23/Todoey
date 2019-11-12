//
//  ViewController.swift
//  Todoey
//
//  Created by mac mini on 12/11/19.
//  Copyright © 2019 mac mini. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    
    let  itemArray = ["find mike" , "buy eggs" , "destroy Demon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
     
    }

    //MARK - tableview datasource methods
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for:  indexPath)
    
        cell.textLabel?.text = itemArray[indexPath.row]
        print(cell)
        
        return cell
}
    
   // MARK - table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
}