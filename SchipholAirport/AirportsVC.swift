//
//  AirportsVC.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 28/10/2020.
//

import UIKit

//  MARK: AirportsVC
/// Map with airports set on it as annotations.
///
class AirportsVC: UIViewController {

  // Reference Types
  var viewModel = MapViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainView()
    viewModel.startMapping()
  }
}
// MARK: - AirportsVC Setup
extension AirportsVC {
  /// Main setup.
  ///
  func setupMainView() {
    setupViewTitle()
    addSubviews()
    activateLayoutConstraints()
  }

  /// Setup view title.
  ///
  func setupViewTitle() {
    title = Localized.airports

    navigationController?
      .navigationBar
      .prefersLargeTitles = true
  }

  /// Adding all subviews into AirportsVC.
  ///
  func addSubviews() {
    guard let mapView = viewModel.mapView as? UIView else { return }
    view.addSubview(mapView)
  }
}

// MARK: - Layouts
extension AirportsVC {
  /// Setup and activate all layouts of the AirportsVC.
  ///
  func activateLayoutConstraints() {
    activateMapViewLayout()
  }

  /// Layout mapView.
  ///
  /// Map view anchored to fit all the view.
  ///
  func activateMapViewLayout() {
    viewModel.mapView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      viewModel.mapView
        .topAnchor
        .constraint(equalTo: view.topAnchor),

      viewModel.mapView
        .leadingAnchor
        .constraint(equalTo: view.leadingAnchor),

      viewModel.mapView
        .trailingAnchor
        .constraint(equalTo: view.trailingAnchor),

      viewModel.mapView
        .bottomAnchor
        .constraint(equalTo: view.bottomAnchor)
    ])
  }
}
