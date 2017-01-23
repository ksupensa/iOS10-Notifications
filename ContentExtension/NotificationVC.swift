//
//  NotificationViewController.swift
//  ContentExtension
//
//  Created by Spencer Forrest on 22/01/2017.
//  Copyright © 2017 Spencer Forrest. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        guard let attachment = notification.request.content.attachments.first else {
                // Do something
                return
        }
        
        // Need to access the attachment outside of App SandBox
        if attachment.url.startAccessingSecurityScopedResource() {
            if let img = try? Data.init(contentsOf: attachment.url) {
                imageView.image = UIImage(data: img)
            }
            
        }
        
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        if response.actionIdentifier == "fistBump" {
            completion(.dismissAndForwardAction)
        } else if response.actionIdentifier == "dismiss" {
            completion(.dismissAndForwardAction)
        }
    }

}
