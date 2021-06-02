//
//  ContentView.swift
//  LocalNotificationsDemo
//
//  Created by Frederick Javalera on 6/2/21.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
  static let instance = NotificationManager() // Singleton
  
  func requestAuthorization() {
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
      if let error = error {
        print("ERROR: \(error)")
      } else {
        print("SUCCESS")
      }
    }
  }
  
  func scheduleNotification() {
    let content = UNMutableNotificationContent()
    content.title = "This is my first notification!"
    content.subtitle = "This was soooo easy!"
    content.sound = .default
    content.badge = 1
    /*
      UNNotificationTrigger types:
      time
      calender
      location
     */
    
//    Time trigger
    let trigger = UNTimeIntervalNotificationTrigger(
      timeInterval: 5.0,
      repeats: false)
    
//    Date trigger
//    var dateComponents = DateComponents()
//    dateComponents.hour = 17
//    dateComponents.minute = 32
//    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    
//    Location Trigger
//    let coordinates = CLLocationCoordinate2D(
//      latitude: 40.00,
//      longitude: 50.00)
//
//    let region = CLCircularRegion(
//      center: coordinates,
//      radius: 50,
//      identifier: UUID().uuidString)
//
//    region.notifyOnEntry = true
//    region.notifyOnExit = false
//
//    let trigger = UNLocationNotificationTrigger(
//      region: region, repeats: true)
    
    let request = UNNotificationRequest(
      identifier: UUID().uuidString,
      content: content,
      trigger: trigger)
    UNUserNotificationCenter.current().add(request)
  }
  
  func cancelNotification() {
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    UNUserNotificationCenter.current().removeAllDeliveredNotifications()
  }
}

struct ContentView: View {
  
    var body: some View {
      
      VStack(spacing:40) {
        
        Button("Request Permission") {
          NotificationManager.instance.requestAuthorization()
        }//: Button
        
        Button("Schedule Notification") {
          NotificationManager.instance.scheduleNotification()
        }//: Button
        
        Button("Cancel Notification") {
          NotificationManager.instance.cancelNotification()
        }//: Button

      }//: VStack
      .onAppear() {
        UIApplication.shared.applicationIconBadgeNumber = 0
      }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
