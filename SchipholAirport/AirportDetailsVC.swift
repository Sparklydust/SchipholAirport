//
//  AirportDetailsVC.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 05/11/2020.
//

import UIKit

//  MARK: AirportDetailsVC
/// Show airport details for airports on map view
/// fetched from api.
///
class AirportDetailsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
      setupMainView()
    }
}

// MARK: - AirportDetailsVC Setup
extension AirportDetailsVC {
  /// Main setup.
  ///
  func setupMainView() {
    setupViewTitle()
  }

  /// Setup view title.
  ///
  func setupViewTitle() {
    title = Localized.details

    navigationController?
      .navigationBar
      .prefersLargeTitles = true
  }
}
