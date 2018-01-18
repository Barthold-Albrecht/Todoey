//
//  ViewController.swift
//  Todoey
//
//  Created by Barthold Albrecht on 16.01.18.
//  Copyright © 2018 Barthold Albrecht. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Idea"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Do it"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Watch it"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
        
    }

        //Mark - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        // Ternary operator ==>
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
        // folgendes wurde durch Ternary operator ersetzt...
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    
    // Mark - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.tableView.reloadData()
        
    }
    
    // Mark - Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New ToDo", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
            // What will happen once user clicked
            
            let newItem = Item()
            newItem.title = textField.text!
           
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Enter new item!"
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
   

    

    
}

