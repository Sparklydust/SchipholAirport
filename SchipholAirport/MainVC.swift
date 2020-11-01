//
//  MainVC.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 28/10/2020.
//

import UIKit

//  MARK: MainVC
/// Entry point of the application that holds the
/// tab bar items.
///
class MainVC: UITabBarController, UITabBarControllerDelegate {

  // Create navigation view controllers for the tab bar items.
  let airportsNC = UINavigationController(rootViewController: AirportsVC())
  let flightsNC = UINavigationController(rootViewController: FlightsVC())
  let airlinesNC = UINavigationController(rootViewController: AirlinesVC())
  let settingsNC = UINavigationController(rootViewController: SettingsVC())

  // Setup the tab bar items icons and titles
  let airportsTabItem = UITabBarItem(
    title: Localized.airports,
    image: .airportsIcon,
    tag: 0)
  let flightsTabItem = UITabBarItem(
    title: Localized.flights,
    image: .flightsIcon,
    tag: 1)
  let airlinesTabItem = UITabBarItem(
    title: Localized.airlines,
    image: .airlinesIcon,
    tag: 2)
  let settingsTabItem = UITabBarItem(
    title: Localized.settings,
    image: .settingsIcon,
    tag: 3)

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainVC()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupTabBarItems()
  }
}

// MARK: - Tab bar items
extension MainVC {
  /// Setup the MainVC with tab bar items.
  ///
  /// Tab bar items are associated with view controllers
  /// as well as icons and titles to represent each of them.
  ///
  func setupTabBarItems() {
    addNavControllersAsTabItems()
    addTabItemsInMainVC()
  }

  /// Associate each navigation controller with its
  /// own icon and title.
  ///
  func addNavControllersAsTabItems() {
    airportsNC.tabBarItem = airportsTabItem
    flightsNC.tabBarItem = flightsTabItem
    airlinesNC.tabBarItem = airlinesTabItem
    settingsNC.tabBarItem = settingsTabItem
  }

  /// Implement the navigation controllers to MainVC.
  ///
  func addTabItemsInMainVC() {
    let controllers = [
      airportsNC,
      flightsNC,
      airlinesNC,
      settingsNC
    ]
    viewControllers = controllers
  }
}

// MARK: - Setup MainVC
extension MainVC {
  /// Add all view setup for this MainVC.
  ///
  /// Setting up the delegates of the view as
  /// well as the colors for each element.
  ///
  func setupMainVC() {
    setupDelegates()
    setupColors()
  }

  /// Add delegates associated to the view.
  ///
  func setupDelegates() {
    delegate = self
  }

  /// Setup all colors represented in MainVC.
  ///
  func setupColors() {
    view.backgroundColor = .background$
    UITabBar.appearance().tintColor = .accentColor$
  }
}
