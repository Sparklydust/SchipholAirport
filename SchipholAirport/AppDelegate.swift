//
//  AppDelegate.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 28/10/2020.
//

import UIKit

//  MARK: AppDelegate
/// SchipholAirport application entry point.
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    openMainVCAtStartup()

    return true
  }
}

// MARK: - First View Setup
extension AppDelegate {
  /// Open programmatically MainVC at startup as first view.
  ///
  func openMainVCAtStartup() {
    let mainVC = MainVC()

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = mainVC
    window?.makeKeyAndVisible()
  }
}
