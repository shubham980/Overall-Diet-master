//
//  GroceryTableViewController.swift
//  OverAll Diet
//
//  Created by Shubham Chaudhary on 4/14/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

/*This class saves the list of the items created in the add grocery list view to the list grocery list and display it in the table view format*/
import Foundation

import UIKit

class GroceryTableViewController: UITableViewController {
    
    //function to go back to the main home screen.
    @IBAction func HomeButtonTap(_ sender: Any) {
        print("clicked1")
        self.navigationController?.dismiss(animated: true, completion: {
            self.view.removeFromSuperview()
        })
    }
    
    var newGroceryItem: String = ""
    
    var groceryList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //downcasting
        if let newGroceryItem = UserDefaults.standard.array(forKey: "list") as? [String] {
            
            //set the instsance value to the the new note
            groceryList = newGroceryItem
        }
    }
    
    /*function to segue and tranition the grovery list into the new grovery list created at the table view*/
    @IBAction func doneButtonTap(segue:UIStoryboardSegue) {
        print("done segue started")
        let addGroceryVC = segue.source as! AddGroceryViewController
        newGroceryItem = addGroceryVC.newGroceryTitle
        groceryList.append(newGroceryItem)
        tableView.reloadData()
        saveGroceryArrayonDevice()
    }
    
    /*function to define the cancel funtionality and transition to the table view with out any changes made*/
    @IBAction func cancelButtonTap(segue:UIStoryboardSegue) {
        print("canceled")
        //        self.navigationController?.dismiss(animated: true, completion: {
        
        let addGroceryVC = segue.source as! AddGroceryViewController
        addGroceryVC.view.removeFromSuperview()
        //        })
    }
    
    //getting the number of rows in the lists
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count
    }
    
    //returning the particular cell that is selected by the user 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groceryCell", for: indexPath)
        cell.textLabel?.text = groceryList[indexPath.row]
        
        return cell
    }
    
    //to save the grocery item on the phone
    func saveGroceryArrayonDevice()  {
        
        //save the updated/modified note
        UserDefaults.standard.set(groceryList, forKey:"list")
        UserDefaults.standard.synchronize()
    }
    
    //function to delete the list items from the table
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            groceryList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            saveGroceryArrayonDevice()
        }
    }
}
