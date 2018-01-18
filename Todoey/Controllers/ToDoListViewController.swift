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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
        loadItems()
       
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
        
        saveItems()
        
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
            
            self.saveItems()
            
            
        }
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Enter new item!"
            textField = alertTextfield
            
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    
    }
    
    // Mark - Model Manipulation Methods
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print(error)
            }
        }
    }
    
}

