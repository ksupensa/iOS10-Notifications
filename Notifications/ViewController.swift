//
//  ViewController.swift
//  Notifications
//
//  Created by Spencer Forrest on 21/01/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    @IBOutlet weak var notifBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Request permission from user
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound], completionHandler: {
            permission, error in
            if permission {
                print("Notification Authorization Granted")
            } else {
                print(error.debugDescription)
            }
        })
    }
    
    @IBAction func notificationBtnPressed(_ sender: UIButton){
        scheduleNotification(inSec: 5, completion: {
            success in
            if success {
                print("Notification successfully scheduled")
            } else {
                print("Error scheduling notification")
            }
        })
    }
    
    /**
     Schedule a default notification and send a request to the User Notification Center
     - Parameters:
       - inSec: Time Interval
       - completion: Closure with a boolean that represents the success of the request
    */
    func scheduleNotification(inSec: TimeInterval, completion: @escaping (_ success: Bool)->()) {
        
        // Add an attachment
        let image = "rick_grimes"
        guard let imageURL = Bundle.main.url(forResource: image, withExtension: "gif") else {
            completion(false)
            print("Image problem")
            return
        }
        
        var attachment: UNNotificationAttachment
        
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageURL, options: .none)
         
        let notif = UNMutableNotificationContent()
        
        // ONLY FOR EXTENSION
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "New notification"
        notif.subtitle = "This is great!"
        notif.body = "This is the new iOS10 notification feature that is really great to me !"
        
        notif.attachments = [attachment]
        
        let notifyTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSec, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifyTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {
            err in
            if err != nil {
                completion(false)
            } else {
                completion(true)
            }
        })
    }
}

