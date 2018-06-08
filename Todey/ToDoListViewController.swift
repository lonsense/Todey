//
//  ViewController.swift
//  Todey
//
//  Created by Michael Garden on 8/06/18.
//  Copyright © 2018 Michael Garden. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    var itemArray = ["Find Mike", "Buy Eggs", "Destroy Demogorgon"]
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
        
    }

    //MARK - Determine the number of rows in the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows : Int = itemArray.count
        return numberOfRows
    }
    
    //MARK - What the cells should display
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text =  itemArray[indexPath.row]
        return cell
    }
   
    //MARK - Tableview Delegate methods (when you click on any part of the table)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
       
        
        //Place a checkmark next to the item when selected
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        //Flashes the selection rather than keeping the grey background
        tableView.deselectRow(at: indexPath, animated: true)
        
       
    
    }
    //MARK - Add item to list
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add new list item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
        
            
            //What happens when the user clicks the add item button on our UI Alert
            self.itemArray.append(textField.text!)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
                
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
      
    }
    

}

