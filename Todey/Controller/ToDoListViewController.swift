//
//  ViewController.swift
//  Todey
//
//  Created by Michael Garden on 8/06/18.
//  Copyright © 2018 Michael Garden. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    var itemArray = [Item]()

    //userDirectory (new Item.plsit)
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadItems()
        
        
    }

    //MARK - Determine the number of rows in the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows : Int = itemArray.count
        return numberOfRows
    }
    
    //MARK - What the cells should display
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text =  item.title
        
        //Ternary Operator
        //value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
   
    //MARK - Tableview Delegate methods (when you click on any part of the table)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
       
        itemArray[indexPath.row].done  =  !itemArray[indexPath.row].done
        saveItems()
        
        tableView.reloadData()
        
        //Flashes the selection rather than keeping the grey background
        tableView.deselectRow(at: indexPath, animated: true)
        
       
    
    }
    //MARK - Add item to list
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        
        let alert = UIAlertController(title: "Add new list item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
        
            
            //What happens when the user clicks the add item button on our UI Alert
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.saveItems()
            
        }
        
            alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
                
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
      
    }

    
    //MARK Model Manipulation Methods
    
    func saveItems() {
    let encoder = PropertyListEncoder()
    
    do {
    let data = try encoder.encode(self.itemArray)
    try data.write(to: self.dataFilePath!)
    }
    
    catch {
    print("Error encoding item array, \(error)")
    }
    
    self.tableView.reloadData()
    
    }

    
    
    //MARK Load Items
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            }
            catch {
                print("Unable decoding item array, \(error)")
                }
            }
        
        
    }
    
    
}

