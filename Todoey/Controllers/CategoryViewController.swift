//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Marcin Szabłowski on 03.04.2018.
//  Copyright © 2018 Marcin Szabłowski. All rights reserved.
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

    //MARK: - Add new categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let categoryAlert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        //Create an action on the bottom of the alert.
        //What happens when Add button is pressed.
        let categoryAction = UIAlertAction(title: "Add", style: .default) { (categoryAction) in
            
            let categoryName = Category(context: self.context)
            categoryName.name = textField.text!
            
            self.categoryArray.append(categoryName)
            print("Category added!")
            
            self.saveCategory()
            
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
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        return cell
        
    }
    
    //MARK: - Data Manipulation Methods
        //TODO: - Save category
    func saveCategory() {
        do {
            try context.save()
        }
        catch {
            print("There was an error saving category to context: \(error)")
        }
        tableView.reloadData()
    }
    
        //TODO: - Load category
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
    
        do {
            categoryArray = try context.fetch(request)
        }
        catch {
            print("There was an error loading category to context: \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
        //tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
        
    }

    
}
