//
//  CoreDataManager.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import CoreData

class NotificationsManager {
    
    static let sharedInstance = NotificationsManager()
    
    private init() {
        print("NotificationsManager Initialized")
    }
    
    let delegate = UIApplication.shared.delegate as? AppDelegate
    
    //add new notification
    func newNotification(date: Date, uuid: String, body: String) {
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar,
                                           timeZone: .current,
                                           month: components.month,
                                           day: components.day,
                                           hour: components.hour,
                                           minute: components.minute)
        if #available(iOS 10.0, *) {
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
            let content = UNMutableNotificationContent()
            content.body = body
            content.sound = UNNotificationSound.default()
            content.userInfo = ["UUID": uuid]
            let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) {(error) in
                if let error = error {
                    print("Uh oh! We had an error: \(error)")
                }
            }
        }else{
            let notification = UILocalNotification()
            notification.fireDate = newComponents.date
            notification.alertBody = body
            notification.userInfo = ["UUID": uuid]
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.scheduleLocalNotification(notification)
        }
        
    }
    
    // unschedule all notification
    func unscheduleAllNotifications() {
        
        if #available(iOS 10.0, *) {
            
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            
        } else {
            UIApplication.shared.cancelAllLocalNotifications()
            
        }
    }
    
    // reschedule all notification
    func rescheduleAllNotifications() {
        let userDefaults = UserDefaults.standard
        let email = userDefaults.string(forKey: "email")
        let medicines: [PatientMedicine] = PatientMedicine.getMedicinesForNurse(email: email!)!
        
        for medicine in medicines {
            //schedule notification
            newNotification(date: medicine.time! as Date, uuid: medicine.uuid!, body: "It's time for \(medicine.patient!.name!) to get \(medicine.medicine!.name!)")
        }
    }
    
}


