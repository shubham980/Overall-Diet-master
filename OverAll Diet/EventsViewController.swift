//
//  EventsViewController.swift
//  OverAll Diet
//
//  Created by Shubham Chaudhary on 4/18/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import UIKit
import EventKit

class EventsViewController: UIViewController, UITableViewDataSource, EventAddedDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var getCalendarTappedFromTheCalendarList: EKCalendar!
    var showEventsFromTheCalendarTappedOn: [EKEvent]?
    var getNewEventAdded: String = ""
    var getStartDateFromEventsPickerView : String = ""
    //    var setStartDateForDateFormatter : Date!
    
    @IBOutlet weak var showEventListTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadEventsInTheTableViewFromEventStore()
    }
    
    // MARK: Event Added Delegate
    func addNewEvents() {
        self.loadEventsInTheTableViewFromEventStore()
        self.showEventListTV.reloadData()
    }
    
    // MARK: Load new events + fetch old Event list from eventsStore
    func loadEventsInTheTableViewFromEventStore() {
        getNewEventAdded = UserDefaults.standard.string(forKey: "GetEventFromCalendar") ?? "Some Event Name"
        getStartDateFromEventsPickerView = UserDefaults.standard.string(forKey: "GetEventStartDateFromPicker") ?? "Some Event's Start Date"
        //        endDate1 = UserDefaults.standard.string(forKey: "GetEventEndDateFromPicker") ?? "Some Event's End Date"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let startDate = dateFormatter.date(from: "2019-01-01")
        let endDate = dateFormatter.date(from: "2020-12-31")
        
        //        setStartDateForDateFormatter = dateFormatter.date(from: getStartDateFromEventsPickerView)
        
        if let startDate = startDate, let endDate = endDate {
            let fetchFromEventStore = EKEventStore()
            
            let fetchEventsfromStartAndEndDatePredicate = fetchFromEventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: [getCalendarTappedFromTheCalendarList])
            
            self.showEventsFromTheCalendarTappedOn = fetchFromEventStore.events(matching: fetchEventsfromStartAndEndDatePredicate).sorted {
                (newEvent: EKEvent, oldEvent: EKEvent) in
                print(newEvent)
                print(oldEvent)
                newEvent.title = getNewEventAdded // add new event in the existing eventstore list
                newEvent.startDate = startDate
                
                print(newEvent.startDate.compare(oldEvent.startDate))
                print(ComparisonResult.orderedAscending)
                return oldEvent.startDate.compare(newEvent.startDate) == ComparisonResult.orderedAscending // set them in ascending order through their start dates
            }
            
            print(self.showEventsFromTheCalendarTappedOn ?? nil!)
        }
    }
    
    // MARK: Events set dateformat in the table view
    func setFormatOfADate(_ date: Date?) -> String {
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
    
    // MARK: set sections for the event list module
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: set row count to be shown in the event list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let events = showEventsFromTheCalendarTappedOn {
            return events.count
        }
        
        return 0
    }
    
    // MARK: Set events in respect to a calendar
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell")!
        cell.textLabel?.text = showEventsFromTheCalendarTappedOn?[(indexPath as NSIndexPath).row].title
        cell.detailTextLabel?.text = setFormatOfADate(showEventsFromTheCalendarTappedOn?[(indexPath as NSIndexPath).row].startDate)
        return cell
    }
    
    //MARK: set segue after adding events
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! UINavigationController
        
        let addEventVC = destinationVC.children[0] as! AddEventViewController
        addEventVC.getCalendarNameSelected = getCalendarTappedFromTheCalendarList
        addEventVC.addEventDelegate = self
    }
    
}
