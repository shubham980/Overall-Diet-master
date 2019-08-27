//
//  ReminderTableViewController.swift
//  OverAll Diet
//
//  Created by Harshita Trehan on 24/05/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import UIKit

class ReminderTableViewController: UITableViewController {
    
    //properties
    var reminderList = [ReminderClass]()
    let calenderDateFormatter = DateFormatter()
    let locale = NSLocale.current
    var homeBarButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //add additional seeting for displaying the date
        calenderDateFormatter.locale = locale
        calenderDateFormatter.dateStyle = .medium
        calenderDateFormatter.timeStyle = .short
        
        //load Reminders
        if let savedReminder = loadReminder() {
            reminderList += savedReminder
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //to get the number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reminderList.count
    }
    
    //configure the cell and return what the view should display
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell", for: indexPath)
        let reminder = reminderList[indexPath.row]
        cell.textLabel?.text = reminder.reminderName
        cell.detailTextLabel?.text = "Due " + calenderDateFormatter.string(from: reminder.time as Date)
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toRemove = reminderList.remove(at: indexPath.row)
            //toRemove.delete(self)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveReminders()
        }
    }
    
    //segue function to create a new row evrytime the user hits the save button and store the same to inform the reminder class
    @IBAction func unwindToReminderList(sender: UIStoryboardSegue){
        if let sourceView = sender.source as? AddReminderVC , let ReminderClass = sourceView.reminder
        {
            //add new reminder
            let newIndexPath = NSIndexPath(row: reminderList.count, section: 0)
            reminderList.append(ReminderClass)
            tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom )
            saveReminders()
            tableView.reloadData()
        }
        
    }
    
    // MARK: - NSCoding
    //check whether the reminder are getting saved or not
    func saveReminders(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(reminderList, toFile: ReminderClass.ArchiveUrl.path)
        if(isSuccessfulSave){
            print("Reminders saved successfully")
        }
        else{
            print("failes to save")
        }
    }
    
    //load reminder and return the type of ReminderClass
    func loadReminder() -> [ReminderClass]?
    {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ReminderClass.ArchiveUrl.path) as? [ReminderClass]
        
    }
    
    //function to return to the home page when tapped on the home button
    override func viewWillAppear(_ animated: Bool) {
        
        homeBarButton = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(backTap1))
        self.navigationItem.leftBarButtonItem  = homeBarButton
    }
    
    //if clicked on the back button the current view gets dismissed to the superview i.e. the home page.
    @objc func backTap1(){
        print("clicked1")
        self.navigationController?.dismiss(animated: true, completion: {
            self.view.removeFromSuperview()
        })
    }
    
}
