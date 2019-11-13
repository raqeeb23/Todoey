//
//  ViewController.swift
//  Todoey
//
//  Created by mac mini on 12/11/19.
//  Copyright © 2019 mac mini. All rights reserved.
//

import UIKit
                                 
class TodoListViewController: UITableViewController {

    
    var  itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        print(dataFilePath)
        
        let newItem = Item()
        newItem.title = "buy bread"
        itemArray.append(newItem)
        
        
        loadItem()
        
        
    }

    //MARK - tableview datasource methods
    
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for:  indexPath)
    
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        print(cell)
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        }else{
//            cell.accessoryType = .none
//        }
        
        return cell
}
    
   // MARK - table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItem()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    //MARK - add new item
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "add new todo item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // when user click add item
            
            let newItem = Item()
            newItem.title = textField.text!
            
            
            self.itemArray.append(newItem)
           
             // self.defaults.set(self.itemArray , forKey: "TodoListArray")
            self.saveItem()
            
            
            
           
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Todo"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    func saveItem(){
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        }catch{
            print("error encoding file path array \(error  )")
        }
        
        
        tableView.reloadData()
    }
    
    
    func loadItem(){
        if  let  data = try? Data(contentsOf: dataFilePath!) {
        let decoder = PropertyListDecoder()
        
        
        do {
            itemArray = try decoder.decode([Item].self , from: data)
        }
        catch{
            print(error)
        }
    }
    
  }
}
