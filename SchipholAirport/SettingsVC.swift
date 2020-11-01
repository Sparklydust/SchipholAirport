//
//  SettingsVC.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 01/11/2020.
//

import UIKit

//  MARK: SettingsVC
/// View controller reponsable for the user settings.
///
class SettingsVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainView()
  }
}

// MARK: - SettingsVC Setup
extension SettingsVC {
  /// Main setup.
  ///
  func setupMainView() {
    setupViewTitle()
  }

  /// Setup view title.
  ///
  func setupViewTitle() {
    title = Localized.settings

    navigationController?
      .navigationBar
      .prefersLargeTitles = true
  }
}
