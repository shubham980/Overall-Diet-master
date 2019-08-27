//
//  CalendarListVC.swift
//  OverAll Diet
//
//  Created by Shubham Chaudhary on 4/18/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import UIKit
import EventKit

class CalendarListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CalendarAddedDelegate {
    
    
    @IBOutlet weak var needPermissionPopUpView: UIView!
    @IBOutlet weak var showCalendarsTableView: UITableView!
    
    var newCalendarItemAdded: String = ""
    
    var theCalendarList: [EKCalendar]?
    let fetchFromEventStore = EKEventStore()
    
    var homeBarButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // check for Calendar Authorization Status.
        checkForCalendarAuthorizationStatus()
    }
    
    func addNewCalendar() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //check for calendar Authorization
        checkForCalendarAuthorizationStatus()
        
        //set home Button on navigationBar Back tap item
        homeBarButton = UIBarButtonItem(title: "Home", style: .done, target: self, action: #selector(backTap1))
        self.navigationItem.leftBarButtonItem  = homeBarButton
    }
    
    //MARK: request Authorization to all calendars if not given
    func checkForCalendarAuthorizationStatus() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch (status) {
        case EKAuthorizationStatus.notDetermined:
            // This happens when user enters this screen for first time
            requestAccessToCalendar()
        case EKAuthorizationStatus.authorized:
            // show the calendars in the table view if they have access
            loadListOfCalendars()
            refreshTableView()
        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
            // We need to help them give us permission
            needPermissionPopUpView.fadeIn()
        }
    }
    
    //MARK: requestAccess to all calendars
    func requestAccessToCalendar() {
        EKEventStore().requestAccess(to: .event, completion: {
            (accessGranted: Bool, error: Error?) in
            // call method if access is Granted
            if accessGranted == true {
                DispatchQueue.main.async(execute: {
                    self.loadListOfCalendars()
                    self.refreshTableView()
                })
            } else {             // request access if not Granted
                DispatchQueue.main.async(execute: {
                    self.needPermissionPopUpView.fadeIn()
                })
            }
        })
    }
    
    
    //MARK: set Calendars from the eventStore + the new added calendars
    func loadListOfCalendars() {
        
        newCalendarItemAdded = UserDefaults.standard.string(forKey: "EventTrackerPrimaryCalendar") ?? "Some Calendar Name"
        
        let calendarss = fetchFromEventStore.calendars(for: EKEntityType.event)
        
        print(calendarss)
        
        self.theCalendarList = EKEventStore().calendars(for: EKEntityType.event).sorted(){
            (cal1 , cal2) -> Bool in
            cal1.title = newCalendarItemAdded
            
            cal2.title = "Previous Calendar"
            
            return cal2.title < cal1.title
        }
        
        for (index, item) in self.theCalendarList!.enumerated() {
            print("Found \(item) at position \(index)")
            print(item)
            print(item.type)
            print([item .value(forKeyPath: "type")])
        }
        
        print(self.theCalendarList)
    }
    
    //MARK: call refreshTableView method
    func refreshTableView() {
        showCalendarsTableView.isHidden = false
        showCalendarsTableView.reloadData()
    }
    
    //MARK: call goToSettingsButtonTapped method
    @IBAction func goToSettingsButtonTapped(_ sender: UIButton) {
        let openSettingsUrl = URL(string: UIApplication.openSettingsURLString)
        UIApplication.shared.openURL(openSettingsUrl!)
    }
    
    //MARK: call tableview numberOfRowsInSection method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let calendars = self.theCalendarList {
            return calendars.count
        }
        
        return 0
    }
    
    //MARK: call tableview cellForRowAtIndexPath method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell")!
        
        if let calendars = self.theCalendarList {
            
            let calendarName = calendars[(indexPath as NSIndexPath).row].title
            
            if (calendarName == "Previous Calendar"){
                cell.accessoryType = UITableViewCell.AccessoryType.none
            }else{
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            }
            cell.textLabel?.text = calendarName
            
            
        } else {
            cell.textLabel?.text = "Unknown Calendar Name"
        }
        
        return cell
    }
    
    //MARK: call tableview didselect method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedIndexPath = showCalendarsTableView.indexPathForSelectedRow!
        
        print(theCalendarList?[(selectedIndexPath as NSIndexPath).row].title ?? "Previouss Calendar")
        
        if (theCalendarList?[(selectedIndexPath as NSIndexPath).row].title == "Previous Calendar"){
            showCalendarsTableView.deselectRow(at: selectedIndexPath, animated: true)
        }else{
            // manually set the Event List Screen call
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let eventsViewController = storyBoard.instantiateViewController(withIdentifier: "EventsViewController") as! EventsViewController
            eventsViewController.getCalendarTappedFromTheCalendarList = theCalendarList?[(indexPath as NSIndexPath).row]
            self.navigationController?.pushViewController(eventsViewController, animated: true)
        }
    }
    
    //MARK: set the segue to go from calendar list screen to calendar Detail screen and Events List screen on tap of calendar cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Segue to the second view controller
        if let identifier = segue.identifier {
            switch identifier {
            case SegueIdentifiers.redirectToAddCalendarSegue:
                let destinationVC = segue.destination as! UINavigationController
                let addCalendarVC = destinationVC.viewControllers[0] as! AddCalendarViewController
                addCalendarVC.addCalendarDelegate = self
            case SegueIdentifiers.redirectToEventsSegue:
                let selectedIndexPath = showCalendarsTableView.indexPathForSelectedRow!
                let eventsVC = segue.destination as! EventsViewController
                eventsVC.getCalendarTappedFromTheCalendarList = theCalendarList?[(selectedIndexPath as NSIndexPath).row]
                
            default: break
            }
        }else if segue.identifier == "showEvents"{
            
        }
        else{
            
        }
    }
    
    // MARK: Calendar Added Delegate
    func calendarDidAdd() {
        
        self.loadListOfCalendars()
        self.refreshTableView()
    }
    
    //MARK: set editing method for the calendars
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        showCalendarsTableView.setEditing(editing, animated: animated)
    }
    
    //MARK: edit the data in the calendar list
    func calendarsTableView(_ tableView: UITableView, commit editingStyle:
        UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        theCalendarList?.remove(at: indexPath.row)
        showCalendarsTableView.deleteRows(at: [indexPath], with: .middle)
        addNewCalendar()
    }
    
    //MARK: set the back Tap t go to Home Screen
    @objc func backTap1(){
        print("clicked1")
        self.navigationController?.dismiss(animated: true, completion: {
            self.view.removeFromSuperview()
        })
    }
}
