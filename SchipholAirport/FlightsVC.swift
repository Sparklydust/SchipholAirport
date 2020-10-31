//
//  FlightsVC.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 28/10/2020.
//

import UIKit

//  MARK: FlightsVC
/// View that populates flights connected to Schiphol.
///
class FlightsVC: UITableViewController {

  // UI
  var activityView: UIActivityIndicatorView?
  var alert = UIAlertController()

  // Data
  var flights = [FlightsData]()

  // References
  var flightsDownloader = NetworkRequest<FlightsData>(.flights)
  let spinner = Spinner()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainView()
    downloadFlights()
  }
}

// MARK: - Networking
extension FlightsVC {
  /// Download flights from flightassets api.
  ///
  /// The completion with @escaping is used to pass expectation
  /// in tests mainly.
  ///
  func downloadFlights(_ completion: @escaping () -> Void = { }) {
    spinner.starts(on: view)
    flightsDownloader.getArray { response in
      switch response {
      case .failure:
        self.spinner.stops()
        self.showDownloadFailureAlert()
        completion()
        return
      case .success(let flights):
        DispatchQueue.main.async {
          self.flights = flights
          self.spinner.stops()
          completion()
        }
      }
    }
  }
}

// MARK: - Table View
extension FlightsVC {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return flights.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: FlightsTVC.identifier, for: indexPath) as! FlightsTVC

    return cell
  }
}

// MARK: - MainVC Setup
extension FlightsVC {
  /// Main setup.
  ///
  func setupMainView() {
    setupViewTitle()
    setupTableView()
  }

  /// Setup table view style and cell type.
  ///
  func setupTableView() {
    tableView.register(FlightsTVC.self, forCellReuseIdentifier: FlightsTVC.identifier)
    tableView.tableFooterView = UIView()
  }

  /// Setup view title.
  ///
  func setupViewTitle() {
    title = Localized.flights
    navigationController?.navigationBar.prefersLargeTitles = true
  }
}

// MARK: - Alerts
extension FlightsVC {
  /// Alert with message to user when download failed.
  ///
  /// A simple ok button to dismiss the alert is added.
  ///
  func showDownloadFailureAlert() {
    alert = UIAlertController(
      title: Localized.downloadFailure,
      message: Localized.downloadFailureMessage,
      preferredStyle: .alert)

    alert.addAction(
      UIAlertAction(
        title: Localized.ok,
        style: .default))

    present(alert, animated: true)
  }
}
