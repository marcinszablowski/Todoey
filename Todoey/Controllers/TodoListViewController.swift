//
//  ViewController.swift
//  Todoey
//
//  Created by Marcin Szabłowski on 22.02.2018.
//  Copyright © 2018 Marcin Szabłowski. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        didSet {
           //  loadItems()
        }
    }
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

//        let newItem = Item() 
//        newItem.title = "Think better"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Be patient"
//        itemArray.append(newItem2)
//
//        loadItems()
    }
    
    // MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary operator
        //value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
            
        return cell
    }

    // MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    // Delete items form the context and array
    // Watch order of these commands
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
    // Set checkmark to opposite of what they are at the moment
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
    // Set checkmark using if-else statement
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
       
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        saveItems()
    }
    
    //MARK - Add New Items
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey", message: "This is a message", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            print("Success!")
    
//            let newItem = Item(context: self.context)
//            newItem.title = textField.text!
//            newItem.done = false
//            newItem.parentCategory = self.selectedCategory
//
//            self.itemArray.append(newItem)
            
            self.saveItems()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //Encode data and reaload TableView
    func saveItems() {
        
        do {
            try context.save()
        }
        catch {
            print("Error saving context  \(error)")
        }
        
        tableView.reloadData()
    }
    
    //Load items. Create fetch request.
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        }
//        else {
//            request.predicate = categoryPredicate
//        }
//
////        let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [categoryPredicate, predicate])
////        request.predicate = compoundPredicate
//
//        do {
//        itemArray = try context.fetch(request)
//        }
//        catch {
//            print("Error loading context \(error)")
//        }
//
//        tableView.reloadData()
//    }

    
//Decode data
//    func loadItems() {
//
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//        do {
//            itemArray = try decoder.decode([Item].self, from: data)
//        } catch {
//            print("Error decoding item array \(error)")
//            }
//
//    }
//
//    }
    
}

// MARK - Search bar methods


