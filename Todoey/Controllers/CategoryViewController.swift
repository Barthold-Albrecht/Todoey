//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Barthold Albrecht on 22.01.18.
//  Copyright © 2018 Barthold Albrecht. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }

  
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
          
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            
            self.saveCategories()
        }
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Enter new category"
            textField = alertTextfield
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    // MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name!
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    // MARK: - TablreView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        
//        context.delete(categoryArray[indexPath.row])
//        categoryArray.remove(at: indexPath.row)
//        tableView.reloadData()
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
      
        
    }
    
    // MARK: - Data Manipulation Methods
    
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        print(context)
        tableView.reloadData()
    }
    

    func loadCategories(with request: NSFetchRequest<Category>=Category.fetchRequest()) {
        
        
        do {
        try categoryArray = context.fetch(request)
        } catch {
            print(error)
        }
        tableView.reloadData()
        
    }
    
    
}
