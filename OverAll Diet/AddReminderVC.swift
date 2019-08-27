//
//  AddReminderVC.swift
//  OverAll Diet
//
//  Created by Harshita Trehan on 24/05/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import UIKit

class AddReminderVC: UIViewController, UITextFieldDelegate {
    
    //creating an object of the ReminderClass
    var reminder: ReminderClass?
    //defining the variables
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var addReminderTextField: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.addReminderTextField.delegate = self
        
        //set the current date and time as the minimum date for the user
        timePicker.minimumDate = NSDate() as Date
        timePicker.locale = NSLocale.current
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose any resources (unwanted)
    }
    
    //check the data in the textfield if it not empty enable the add button
    func checkName(){
        let text = addReminderTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    //check the date , set it to the current day if it not empty enable the add button
    func checkDate(){
        //Disable save button if the date in the date picker has passed
        if NSDate().earlierDate(timePicker.date) == timePicker.date{
            saveButton.isEnabled = false
        }
    }
    
    //disable the textfield once the user hits the return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //add the data in the text field to the title of the page
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkName()
        navigationItem.title = textField.text
    }
    
    //disable the save button if the user is typing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    //check date where the user tabs on the datePaicker
    @IBAction func timeChanged(_ sender: UIDatePicker) {
        checkDate()
    }
    
    //dismiss the view and does not save if Cancel button is tapped
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //segue function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //referenincg the exact same thing
        if saveButton === sender as AnyObject? {
            let reminderName = addReminderTextField.text
            var time = timePicker.date
            let timeInterval = floor(time.timeIntervalSinceReferenceDate/60) * 60
            time = NSDate(timeIntervalSinceReferenceDate: timeInterval) as Date
            //build notification
            let notification = UILocalNotification()
            notification.alertTitle = "Reminder"
            notification.alertBody = "Reminder Alert: Dont forget \(String(describing: reminderName))"
            notification.fireDate = time
            notification.soundName = UILocalNotificationDefaultSoundName
            
            //schedule the notification by passing the textfirld in the name and gathering the timer that user selected
            UIApplication.shared.scheduleLocalNotification(notification)
            reminder = ReminderClass(reminderName: reminderName!, time: time as NSDate, notification: notification)
            
        }
    }
    
    
}
