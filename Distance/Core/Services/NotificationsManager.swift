//
//  NotificationsManager.swift
//  Distance
//
//  Created by Aaron Wilson on 4/10/23.
//

import Foundation
import UserNotifications
import SwiftUI

class NotificationsManager {
    static let instance = NotificationsManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                print("SUCCESS Notification permisson was established")
            }
        }
    }
    
    func distanceNotification(span: SpanModel, timeFrame: String) {
        
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Wow you're crushing it!"
        content.body = "\(timeFrame) You've walked the length of \(span.name)"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("Error requesting distance notification \(error)")
            }
        }
    }
    
    func scheduleNotification(miles: Double) {
        // Step 1: Create a UNUserNotificationCenter instance
        let center = UNUserNotificationCenter.current()
        
        // Step 2: Define the notification content
        let content = UNMutableNotificationContent()
        content.title = "You have walked \(miles.asDistanceWith2Decimals()) miles!"
        
        
        // Step 3: Define the trigger based on the specified date
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        // Step 4: Create a request with the specified content and trigger
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // Step 5: Add the request to the notification center
        center.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
            print("Notification scheduled")
        }
    }
}
