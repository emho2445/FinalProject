//
//  PushNotificationService.swift
//  FinalProject
//
//  Created by Emma  Hopson on 10/24/23.
//

import Foundation
import NotificationCenter

class PushNotificationService: ObservableObject {
     @Published var isPermissionGranted: Bool = false

    func requestPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            DispatchQueue.main.async{
                if success {
                    self.isPermissionGranted = true
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func scheduleNotification(coordinates: String, subtitle: String, time: Date) {
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: time)
        let minute = calendar.component(.minute, from: time)
        let seconds = calendar.component(.second, from: time)
        let day = calendar.component(.day, from: time)
        let month = calendar.component(.month, from: time)
        let year = calendar.component(.year, from: time)
        
        let components = DateComponents(calendar: calendar, year: year ,month: month, day: day, hour: hour, minute: minute, second: seconds)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = coordinates
        //For debugging the variable 'hour' comment out line 54 and uncomment lines 55 and 56
        notificationContent.subtitle = subtitle
        //notificationContent.subtitle = hour
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)

        let notificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        print(components)

        UNUserNotificationCenter.current().add(notificationRequest)
    }
}

