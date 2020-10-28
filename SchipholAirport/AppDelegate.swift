//
//  AppDelegate.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 28/10/2020.
//

import UIKit

//  MARK: AppDelegate
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let mainViewController = MainViewController()

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = mainViewController
    window?.makeKeyAndVisible()

    return true
  }
}
