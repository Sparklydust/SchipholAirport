//
//  AirportsVC.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 28/10/2020.
//

import UIKit
import MapKit

//  MARK: AirportsVC
/// Map with airports set on it as annotations.
///
class AirportsVC: UIViewController {

  var mapView = MKMapView()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainView()
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
    mapView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      mapView
        .topAnchor
        .constraint(equalTo: view.topAnchor),

      mapView
        .leadingAnchor
        .constraint(equalTo: view.leadingAnchor),

      mapView
        .trailingAnchor
        .constraint(equalTo: view.trailingAnchor),

      mapView
        .bottomAnchor
        .constraint(equalTo: view.bottomAnchor)
    ])
  }
}
