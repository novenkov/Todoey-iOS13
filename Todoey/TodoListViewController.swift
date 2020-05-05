//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    //Example array of items
    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
    
    //Create user defaults
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load array from defaults
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }
        
    }
    
    //MARK: - Tableview Datasource Methods
    
    // Set number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //Configure cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Return reusable cell for ID
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        //Assign value to cell from items array
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Print which row is selected
        //print(itemArray[indexPath.row])
        
        //Adding checkmark to cell
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //Animate deselect row after selection
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        //Create local var with succes item
        var textField = UITextField()
        
        //Create alert view
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        //Create alert action
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //What will happend once the user clicks the Add Item button on our UIAlert
            //print(textField.text)
            
            //Add new element to array itemArray
            self.itemArray.append(textField.text!)
            
            //Store array in defaults
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            //Reload table VC
            self.tableView.reloadData()
        }
        
        //Add textfield to alert
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField //Assign local var with TF value
        }
        
        alert.addAction(action) //Add action to alert
        
        present(alert, animated: true, completion: nil) //Present alert
    }
    
    
}

