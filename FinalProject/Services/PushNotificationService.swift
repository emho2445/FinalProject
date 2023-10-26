//
//  PushNotificationService.swift
//  FinalProject
//
//  Created by Emma  Hopson on 10/24/23.
//

import Foundation
import NotificationCenter

class PushNotificationService {
    var isPermissionGranted = false

    func requestPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                self.isPermissionGranted = true
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    func scheduleNotification(coordinates: String, subtitle: String, time: String) {
        //Parses the string time entered ("##:##:## AM/PM") into two segments ["##:##:##", "AM/PM"] by space
        let firstTimeParse = time.split(separator: " ")
        
        //Parses the first element of the array above "##:##:##" into three segments ["##", "##", "##"] by :
        let secondTimeParse = firstTimeParse[0].split(separator: ":")
        
        var hour = Int() // will hold the int value of military time
        
        //The outter most if statement checks the AM/PM element to see which time of day it is since we need to convert PM times to military
        if firstTimeParse[1] == "PM"{
            //The if statement checks to see if it is noon. If it is noon then we don't want to do anything with the hour
            if secondTimeParse[0] == "12"{
                hour = (Int(secondTimeParse[0]) ?? 200) // If noon keep the hour as is
            }else{
                hour = (Int(secondTimeParse[0]) ?? 200) + 12 // If not noon add 12 hours to turn into military time
            }
            
        }else{
            //The if statement checks to see if it is midnight. If it is midnight then that is hour zero in military time
            if secondTimeParse[0] == "12"{
                hour = 0 // If midnight change hour to 0 for military time
            }else{
                hour = Int(secondTimeParse[0]) ?? 100 // If not midnight keep the hour as it
            }
        }
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = coordinates
        //For debugging the variable 'hour' comment out line 54 and uncomment lines 55 and 56
        notificationContent.subtitle = subtitle
        //notificationContent.subtitle = hour
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let trigger = UNCalendarNotificationTrigger(dateMatching: .init(year: 2023, month: 10, day: 14, hour: hour, minute: Int(secondTimeParse[1])), repeats: true)

        let notificationRequest = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)

        UNUserNotificationCenter.current().add(notificationRequest)
    }
}

