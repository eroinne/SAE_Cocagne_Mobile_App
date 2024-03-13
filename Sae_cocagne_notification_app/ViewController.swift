//
//  ViewController.swift
//  Sae_cocagne_notification_app
//
//  Created by Ero on 13/03/2024.
//

import Foundation

import UIKit
import UserNotifications

class ViewController: UIViewController, ObservableObject{

  var notificationPermissionGranted = false

  override func viewDidLoad() {
    super.viewDidLoad()
    checkForNotificationPermission()
  }

  func checkForNotificationPermission() {
    let notificationCenter = UNUserNotificationCenter.current()
    notificationCenter.getNotificationSettings() { settings in
      switch settings.authorizationStatus {
      case .authorized, .provisional:
        self.notificationPermissionGranted = true
        print("Notification permission granted")
      case .notDetermined:
        print("Notification permission not determined")
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { granted, error in
          if granted {
            self.notificationPermissionGranted = true
          } else {
            self.notificationPermissionGranted = false
          }
          // Dispatch notification only after permission check completes
          if self.notificationPermissionGranted {
            self.dispatchNotification()
          }
        }
      case .denied:
        self.notificationPermissionGranted = false
        print("Notification permission denied")
      default:
        break
      }
    }
  }

    func dispatchNotification() {
        
        print("dispatching Notification")
        let identifier = "Panier livrer"
        let title = "Panier livrer"
        let body = "Votre panier a été livré"
        
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: nil) // No trigger, send immediately
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error: \(error)")
            }else{
                print("Notification dispatched")
            }
        }
    }
  }


    

