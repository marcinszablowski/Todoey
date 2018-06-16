//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Marcin Szabłowski on 03.04.2018.
//  Copyright © 2018 Marcin Szabłowski. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }

    //MARK: - Add new categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let categoryAlert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        //Create an action on the bottom of the alert.
        //What happens when Add button is pressed.
        let categoryAction = UIAlertAction(title: "Add", style: .default) { (categoryAction) in
            
            let categoryName = Category()
            categoryName.name = textField.text!
            
            print("Category added!")
            
            self.save(category: categoryName)
            
        }
        
        //Add "categoryAction" action to the alert.
        categoryAlert.addAction(categoryAction)
        
        //Add "alertTextField" text field to the alert.
        categoryAlert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        
        //Present the alert on the screen when + button is pressed.
        //categoryAlert.addAction(categoryAction)
        present(categoryAlert, animated: true, completion: nil)
        
        
    }

    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet!"
        
        return cell
        
    }
    
    //MARK: - Data Manipulation Methods
    //Persisting data using Realm
    
    func save(category: Category) {
        
        do {
            try! realm.write {
                realm.add(category)
            }
        }
        catch {
            print("There was an error saving category: \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    //TODO: - Load category
    
    func load(){
        
        categories = realm.objects(Category.self)
    
        tableView.reloadData()
        
     }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }

    
}
