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
  let airportDetailsVC = AirportDetailsVC()
  var airportDetailsData: AirportDetailsData?

  // Constants
  static let detailsModalNotification = "detailsModalNotification"
  static let airportDetailsNotification = "airportDetailsNotification"

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

  /// Add NotificationCenter to AirportsVC.
  ///
  func addNotifications() {
    listenAirportDetailsDataNotification()
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
                    .Name(rawValue: AirportsVC.detailsModalNotification),
                   object: nil)
  }

  /// Present AirportDetailsVC modal view.
  ///
  @objc func presentDetailsModalView(notif: NSNotification) {
    sendAirportDetailsData(to: airportDetailsVC)
    present(airportDetailsVC, animated: true, completion: nil)
  }

  /// Setup AirportDetailsVC variables.
  ///
  /// Add value fetch from MapViewModel via a notification
  /// and set AirportDetailsVC from AirportsVC before showing
  /// the modal view with details.
  ///
  func sendAirportDetailsData(to vc: AirportDetailsVC) {
    let failure = Localized.failure
    vc.id = airportDetailsData?.airportData.id ?? failure
    vc.latitude = airportDetailsData?.airportData.latitude ?? .zero
    vc.longitude = airportDetailsData?.airportData.longitude ?? .zero
    vc.name = airportDetailsData?.airportData.name ?? failure
    vc.city = airportDetailsData?.airportData.city ?? failure
    vc.countryId = airportDetailsData?.airportData.countryId ?? failure
    vc.nearestAirport = airportDetailsData?.nearestAirport ?? failure
    vc.distanceAirports = airportDetailsData?.airportsDistance ?? .zero
  }

  /// Listen to notification from MapViewModel to fetch
  /// airport details from view model.
  ///
  func listenAirportDetailsDataNotification() {
    NotificationCenter
      .default
      .addObserver(self,
                   selector: #selector(populateAirportDetailsData),
                   name: NSNotification
                    .Name(rawValue: AirportsVC.airportDetailsNotification),
                   object: nil)
  }

  /// Receive the airport details data from mapViewModel
  /// and perform action with them.
  ///
  @objc func populateAirportDetailsData(_ notification: NSNotification) {
    guard let dict = notification.userInfo as NSDictionary?,
          let airportDetails = dict[MapViewModel.airportDetailskey]
            as? AirportDetailsData else { return }
    airportDetailsData = airportDetails
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
