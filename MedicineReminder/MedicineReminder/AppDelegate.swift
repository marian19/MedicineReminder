//
//  AppDelegate.swift
//  MedicineReminder
//
//  Created by Marian on 6/23/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.sharedManager().enable = true
        
        let color = UIColor(red: 2/255, green: 119/255, blue: 189/255, alpha: 1)
        UINavigationBar.appearance().barTintColor = color
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        
        UITabBar.appearance().barTintColor = color
        UITabBar.appearance().tintColor = UIColor.white
        
        if #available(iOS 10.0, *) {
            
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]) { (granted, error) in
                
                if granted {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                
            }
            
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            
            application.registerUserNotificationSettings(settings)
        }
        
        return true
    }
    
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        let topWindow = UIWindow(frame: UIScreen.main.bounds)
        topWindow.rootViewController = UIViewController()
        topWindow.windowLevel = UIWindowLevelAlert + 1
        let alert = UIAlertController(title: "Notification", message: notification.alertBody, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
            
            topWindow.isHidden = true
        }))
        topWindow.makeKeyAndVisible()
        topWindow.rootViewController?.present(alert, animated: true, completion: { _ in })
    }
    

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        CoreDataManager.sharedInstance.saveContext()
    }
}

