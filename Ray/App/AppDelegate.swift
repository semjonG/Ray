//
//  AppDelegate.swift
//  Ray
//
//  Created by mac on 09.05.2023.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.rootViewController = TabBarController()
    return true
  }
 
  func applicationWillResignActive(_ application: UIApplication) {
    try? CoreDataManager.shared.saveToContext()
  }
}
