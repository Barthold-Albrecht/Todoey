//
//  ViewController.swift
//  Todoey
//
//  Created by Barthold Albrecht on 16.01.18.
//  Copyright © 2018 Barthold Albrecht. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    var toDoItems: Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet{
            
            loadItems()
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
       
       
        }
    

    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        if let item = toDoItems?[indexPath.row] {
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
            
        } else {
            cell.textLabel?.text = "No item added yet!"
        }
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
    }
    
    
    // MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[indexPath.row] {
            do {
                try realm.write {
                    
//                    realm.delete(item)
                    item.done = !item.done
                    
                }
                
                } catch {
               print(error)
            
            }
            tableView.reloadData()
        }
 
        tableView.deselectRow(at: indexPath, animated: true)
        
//        saveItems()
        
    }
    
    // MARK: - Add New Item
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New ToDo", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) {
            (action) in
            // What will happen once user clicked
            
            if let currentCategory = self.selectedCategory {
                do {
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = textField.text!
                    let date = Date()
                    newItem.date = date
                    
                    currentCategory.items.append(newItem)
                    }
                } catch {
                     print(error)
                    }
            }
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Enter new item!"
            textField = alertTextfield
            
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    
    }
    
    // MARK: - Model Manipulation Methods
    
  
    
    func loadItems() {

       toDoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()

    }
    
}

// MARK: - Search Bar extensions

extension ToDoListViewController: UISearchBarDelegate {



    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "date", ascending: true)
            tableView.reloadData()
    }
        
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            
            loadItems()

            DispatchQueue.main.async {
              searchBar.resignFirstResponder()
            }
        }
        
    }

        
    }

 
    // Eigene Lösung für obiges
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchBar.showsCancelButton = true}
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        loadItems()
//        searchBar.showsCancelButton = false}
    
    
//}

