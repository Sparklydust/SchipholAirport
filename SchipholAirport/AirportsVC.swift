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

  // Modal view
  let airportDetailsNC = UINavigationController(
    rootViewController: AirportDetailsVC())

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
    setupDesign()
    addSubviews()
    activateLayoutConstraints()
    addNotifications()
  }

  /// Setup view design.
  ///
  func setupDesign() {
    setupViewTitle()
    setupAirportDetailsModalView()
  }

  /// Setup view title.
  ///
  func setupViewTitle() {
    title = Localized.airports

    navigationController?
      .navigationBar
      .prefersLargeTitles = true
  }

  /// Setup AirportDetailsVC as a modal view.
  ///
  func setupAirportDetailsModalView() {
    airportDetailsNC.modalPresentationStyle = .pageSheet
    airportDetailsNC.modalTransitionStyle = .coverVertical
  }

  /// Adding all subviews into AirportsVC.
  ///
  func addSubviews() {
    guard let mapView = viewModel.mapView as? UIView else { return }
    view.addSubview(mapView)
  }

  func addNotifications() {
    listenShowModalNotification()
  }
}

// MARK: - Notifications
extension AirportsVC {
  /// Listen to notification from MapViewModel to trigger
  /// modal view with AirportDetailsVC.
  ///
  func listenShowModalNotification() {
    NotificationCenter
      .default
      .addObserver(self,
                   selector: #selector(presentDetailsModalView),
                   name: NSNotification
                    .Name(rawValue: AirportDetailsVC.detailsNotification),
                   object: nil)
  }

  /// Present AirportDetailsVC modal view.
  ///
  @objc func presentDetailsModalView(notif: NSNotification) {
    present(airportDetailsNC, animated: true)
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
