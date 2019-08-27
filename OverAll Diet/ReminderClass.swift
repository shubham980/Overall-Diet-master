//
//  ReminderClass.swift
//  OverAll Diet
//
//  Created by Harshita Trehan on 24/05/19.
//  Copyright © 2019 Deakin. All rights reserved.
//

import Foundation
import UIKit

class ReminderClass: NSObject, NSCoding{
    //setting the properties
    var notification: UILocalNotification
    var reminderName: String
    var time: NSDate
    
    //paths when the app tries to save the data
    //specific document directory on the phone
    static let DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveUrl = DocumentDirectory.appendingPathComponent("reminder")
    
    //enum for properties keys
    struct propertyKey{
        static let reminderNameKey = "reminderName"
        static let reminderTimeKey = "time"
        static let reminderNotificationKey = "notification"
    }
    
    //Initialiser
    init(reminderName: String , time: NSDate , notification: UILocalNotification) {
        self.reminderName = reminderName
        self.time = time
        self.notification = notification
    }
    
    //destructor
    deinit {
        //cancel notification
        UIApplication.shared.cancelLocalNotification(self.notification)
        
    }
    
    //NSCoding
    //encoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(reminderName, forKey: propertyKey.reminderNameKey)
        aCoder.encode(time, forKey: propertyKey.reminderTimeKey)
        aCoder.encode(notification, forKey: propertyKey.reminderNotificationKey)
    }
    
    //decoding
    required convenience init(coder aDecoder: NSCoder) {
        let reminderName = aDecoder.decodeObject(forKey: propertyKey.reminderNameKey) as! String
        let time = aDecoder.decodeObject(forKey: propertyKey.reminderTimeKey) as! NSDate
        let notification = aDecoder.decodeObject(forKey: propertyKey.reminderNotificationKey) as!  UILocalNotification
        
        self.init(reminderName: reminderName, time: time, notification: notification)
    }
    
}
