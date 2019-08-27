//
//  AddEventViewController.swift
//  OverAll Diet
//
//  Created by Shubham Chaudhary on 4/18/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import UIKit
import EventKit

class AddEventViewController: UIViewController {
    
    var getCalendarNameSelected: EKCalendar!
    
    @IBOutlet weak var setEventNameTextField: UITextField!
    @IBOutlet weak var getEventStartDatePicker: UIDatePicker!
    @IBOutlet weak var getEventEndDatePicker: UIDatePicker!
    
    // Create an Event Store instance here
    let getEventsFromEventStoreForTheCalendarSelected = EKEventStore()
    
    var addEventDelegate: EventAddedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set start date in the datePickerView
        self.getEventStartDatePicker.setDate(initialDatePickerValue(), animated: false)
        
        //set end date in the datePickerView
        self.getEventEndDatePicker.setDate(initialDatePickerValue(), animated: false)
    }
    
    //MARK: show date pickers , by default value set to today
    func initialDatePickerValue() -> Date {
        let calendarUnitFlags: NSCalendar.Unit = [.year, .month, .day, .hour, .minute, .second]
        
        var dateComponents = (Calendar.current as NSCalendar).components(calendarUnitFlags, from: Date())
        
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        
        return Calendar.current.date(from: dateComponents)!
    }
    
    //MARK: On tap of Cancel button we dismiss from the screen without adding the events in the eventstore
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: On tap of Add Event we add the event in accordance to calendar in the eventstore
    @IBAction func addEventButtonTapped(_ sender: UIBarButtonItem) {
        let getCalendarsList = getEventsFromEventStoreForTheCalendarSelected.calendars(for: EKEntityType.event)
        
        if getEventsFromEventStoreForTheCalendarSelected.calendar(withIdentifier: self.getCalendarNameSelected.calendarIdentifier) != nil{
            
            for calendarForEvent in getCalendarsList{
                if let calendarForEvent = getEventsFromEventStoreForTheCalendarSelected.calendar(withIdentifier: self.getCalendarNameSelected.calendarIdentifier){
                    let setNewEventInstance = EKEvent(eventStore: getEventsFromEventStoreForTheCalendarSelected)
                    
                    checkForEventAuthorizationStatus()
                    
                    setNewEventInstance.calendar = calendarForEvent
                    print(getCalendarNameSelected)
                    print(calendarForEvent)
                    setNewEventInstance.title = self.setEventNameTextField.text ?? "Some Event Name"
                    setNewEventInstance.startDate = self.getEventStartDatePicker.date
                    setNewEventInstance.endDate = self.getEventEndDatePicker.date
                    
                    // Save the event using the Event Store instance
                    do {
                        try getEventsFromEventStoreForTheCalendarSelected.save(setNewEventInstance, span: .thisEvent, commit: true)
                        addEventDelegate?.addNewEvents()
                        
                        UserDefaults.standard.set(self.setEventNameTextField.text!, forKey: "GetEventFromCalendar")
                        
                        UserDefaults.standard.setValue(self.getEventStartDatePicker.date, forKey: "GetEventStartDateFromPicker")
                        
                        UserDefaults.standard.setValue(self.getEventEndDatePicker.date, forKey: "GetEventEndDateFromPicker")
                        UserDefaults.standard.synchronize()
                        
                        self.dismiss(animated: true, completion: nil)
                    } catch {
                        let alert = UIAlertController(title: "OOps - We are unable to save this event.", message: (error as NSError).localizedDescription, preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(OKAction)
                        
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    //MARK: Request for Calendar Access to add events
    func requestCalendarAndEventPermissions() {
        getEventsFromEventStoreForTheCalendarSelected.requestAccess(to: .event, completion: {(accessGranted: Bool, error: Error?) in
            
            if accessGranted == true {
                print("Access Has Been Granted")
            }
            else {
                print("Pop to Settings to Allow Access")
            }
        })
    }
    
    //MARK: check for calendar + event status in the eventstore
    func checkForEventAuthorizationStatus() {
        let getStatus = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        if getStatus == EKAuthorizationStatus.notDetermined {
            requestCalendarAndEventPermissions()
        }
        else if getStatus == EKAuthorizationStatus.authorized {
            print("Access Has Been Granted")
        }
        else if (getStatus == EKAuthorizationStatus.denied) || (getStatus == EKAuthorizationStatus.restricted){
            print("Access Has Been Denied by the user")
        }
    }
    
//    MARK: If we have the value set it to current event set otherwise it will throw the error for not saving the event in the eventstore due to permission issues
//    func showAlertFunc() ->  Void{
//        if let calendarForEvent = getEventsFromEventStoreForTheCalendarSelected.calendar(withIdentifier: self.getCalendarNameSelected.calendarIdentifier){
//            let setNewEventInstance = EKEvent(eventStore: getEventsFromEventStoreForTheCalendarSelected)
//
//            checkForEventAuthorizationStatus()
//
//            setNewEventInstance.calendar = calendarForEvent
//            print(getCalendarNameSelected)
//            print(calendarForEvent)
//            setNewEventInstance.title = self.setEventNameTextField.text ?? "Some Event Name"
//            setNewEventInstance.startDate = self.getEventStartDatePicker.date
//            setNewEventInstance.endDate = self.getEventEndDatePicker.date
//
//            // Save the event using the Event Store instance
//            do {
//                try getEventsFromEventStoreForTheCalendarSelected.save(setNewEventInstance, span: .thisEvent, commit: true)
//                addEventDelegate?.eventDidAdd()
//
//                UserDefaults.standard.set(self.setEventNameTextField.text!, forKey: "GetEventFromCalendar")
//
//                UserDefaults.standard.setValue(self.getEventStartDatePicker.date, forKey: "GetEventStartDateFromPicker")
//
//                UserDefaults.standard.setValue(self.getEventEndDatePicker.date, forKey: "GetEventEndDateFromPicker")
//                UserDefaults.standard.synchronize()
//
//                self.dismiss(animated: true, completion: nil)
//            } catch {
//                let alert = UIAlertController(title: "OOps - We are unable to save this event.", message: (error as NSError).localizedDescription, preferredStyle: .alert)
//                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                alert.addAction(OKAction)
//
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
//    }
}
