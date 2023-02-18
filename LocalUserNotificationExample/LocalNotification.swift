//
//  LocalNotification.swift
//  LocalUserNotificationExample
//
//  Created by Türker Alan on 26.01.2023.
//

import Foundation
import UserNotifications

class LocalNotification: NSObject {
    static let shared: LocalNotification = LocalNotification()
    
    func checkForAuthorization() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.sendLocalNotification()
                    }
                }
            case .denied:
                print("denied")
                return
            case .authorized:
                self.sendLocalNotification()
            default:
                return
            }
        }
    }
    
    func sendLocalNotification() {
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "We are currently unable to recognize this image"
        content.body = "We are waiting for the update from the server."
        content.sound = .default
     
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        let uuid = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        notificationCenter.delegate = self
        notificationCenter.removeAllPendingNotificationRequests()
        notificationCenter.add(request)
    }
}

extension LocalNotification: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}
