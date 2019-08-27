//
//  AddCalendarViewController.swift
//  OverAll Diet
//
//  Created by Shubham Chaudhary on 4/18/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import UIKit
import EventKit

class AddCalendarViewController: UIViewController {
    
    // Create an Event Store instance here to fetch the calendar List
    let getCalendarsFromEventStore = EKEventStore();
    
    // Create UITextfield Instance to retrieve the text entered
    @IBOutlet weak var setCalendarNameInTextField: UITextField!
    
    //setCalendarDelegate class instance
    var addCalendarDelegate: CalendarAddedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: On tap of Cancel button we dismiss from the screen without adding the calendar in the eventstore
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: On tap of Add Calender we add the calendar in the eventstore
    @IBAction func addCalendarButtonTapped(_ sender: UIBarButtonItem) {
        
        // Use Event Store to create a new calendar instance
        let addNewCalendar = EKCalendar(for: .event, eventStore: getCalendarsFromEventStore)
        
        // Configure the calendar name added
        addNewCalendar.title = setCalendarNameInTextField.text ?? "Some Calendar Name"
        
        // Access list of available sources from the Event Store
        let sourcesInEventStore = getCalendarsFromEventStore.sources
        
        // Filter the available sources and select the "Local" source to assign to the new calendar's
        // source property
        addNewCalendar.source = sourcesInEventStore.filter{
            (source: EKSource) -> Bool in
            source.sourceType.rawValue == EKSourceType.local.rawValue
            }.first!
        
        // Save the calendar using the Event Store instance
        do {
            // save the added calendar in the userdefaults to show in the calendar list
            UserDefaults.standard.set(setCalendarNameInTextField.text!, forKey: "EventTrackerPrimaryCalendar")
            UserDefaults.standard.synchronize()
            
            //get the calendar name from UITextfield
            addNewCalendar.title = setCalendarNameInTextField.text!
            
            //save this new Calendar added in the eventstore
            try getCalendarsFromEventStore.saveCalendar(addNewCalendar, commit: true)
            
            //set delegate for new calendar added
            addCalendarDelegate?.addNewCalendar()
            
            //go back to the root screen to show in the calendar list
            self.dismiss(animated: true, completion: nil)
        } catch {
            //show alert when eventstore cannot store/save the calendar added
            let alert = UIAlertController(title: "Calendar could not save", message: (error as NSError).localizedDescription, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OKAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
