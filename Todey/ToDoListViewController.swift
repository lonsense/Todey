//
//  ViewController.swift
//  Todey
//
//  Created by Michael Garden on 8/06/18.
//  Copyright © 2018 Michael Garden. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    
    let itemArray = ["Find Mike", "Buy Eggs", "Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //Determine the number of rows in the table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows : Int = itemArray.count
        return numberOfRows
    }
    
    //What the cells should display
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
    
    

}

