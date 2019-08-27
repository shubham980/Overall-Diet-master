//
//  AddGroceryViewController.swift
//  OverAll Diet
//
//  Created by Shubham Chaudhary on 4/14/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

/* This class adds on the data that the user eants to add in grocery list and then
 transitions the list of grocery items that the user has enter to display it in the form of list in the transitioned class*/
import Foundation

import UIKit

class AddGroceryViewController: UIViewController{
    
    var newGroceryTitle: String = ""
    
    @IBOutlet weak var AddGroceryTF: UITextField!
    
    //function to add the content of the bisy and then disply it to the list in the table view controller(segue used to suffice the transaction from one class to the another)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            newGroceryTitle = AddGroceryTF.text!
        }
        if segue.identifier == "cancelSegue" {
            print("clicked1")
            
        }
    }
    
}

