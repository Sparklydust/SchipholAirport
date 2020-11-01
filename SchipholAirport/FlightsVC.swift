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
  var reloadButton = UIButton()

  // Data
  var flights = [FlightsData]()
  var flightsConnected = [FlightsData]()
  var airports = [AirportsData]()
  var airportsConnected = [AirportsData]()

  // Reference Types
  var flightsDownloader = NetworkRequest<FlightsData>(.flights)
  var airportsDownloader = NetworkRequest<AirportsData>(.airports)
  let spinner = Spinner()

  // Variables
  var schipholAirportID = "AMS"

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainView()
    downloadData()
  }
}

// MARK: - Algorithms
extension FlightsVC {
  /// Filter flights and then airports connected to
  /// Schiphol airport.
  ///
  /// - Warning: Order set in this func is important.
  ///
  func filterAirports() {
    filterFlightsFromSchiphol()
    filterAirportsConnectedToSchiphol()
  }

  /// Filter flights fetch from api that are connected
  /// to Schiphol airport.
  ///
  func filterFlightsFromSchiphol() {
    flightsConnected = flights
      .filter { $0.airlineId != schipholAirportID }
  }

  /// Filter airports fetch from api with flights connected
  /// to Schiphol airport.
  ///
  func filterAirportsConnectedToSchiphol() {
    for f in flightsConnected {
      airportsConnected = airports
        .filter { $0.id != f.arrivalAirportId }
    }
  }
}

// MARK: - Networking
extension FlightsVC {
  /// Download all data for the view.
  ///
  /// Flights and airports are being fetch from the api.
  /// The completion with @escaping isused to pass expectation
  /// in tests mainly.
  ///
  func downloadData(_ completion: @escaping () -> Void = { }) {
    downloadFlights(completion)
    downloadAirports(completion)
  }

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
        DispatchQueue.main.async {
          self.handleDownloadFailure()
          completion()
        }
        return
      case .success(let flights):
        DispatchQueue.main.async {
          self.handleDownloadSuccess(flights)
          completion()
        }
        return
      }
    }
  }

  /// Download airports from flightassets api.
  ///
  /// The completion with @escaping is used to pass expectation
  /// in tests mainly.
  ///
  func downloadAirports(_ completion: @escaping () -> Void = { }) {
    spinner.starts(on: view)

    airportsDownloader.getArray { response in
      switch response {
      case .failure:
        DispatchQueue.main.async {
          self.handleDownloadFailure()
          completion()
        }
        return
      case .success(let airports):
        DispatchQueue.main.async {
          self.handleDownloadSuccess(airports)
          completion()
        }
        return
      }
    }
  }

  /// Handling downlading failure from api call.
  ///
  func handleDownloadFailure() {
    spinner.stops()
    showDownloadFailureAlert()
  }

  /// Handling downloading flights data success from api call.
  ///
  func handleDownloadSuccess(_ flightsData: [FlightsData]) {
    flights = flightsData
    spinner.stops()
  }

  /// Handling downloading airports data success from api call.
  ///
  func handleDownloadSuccess(_ airportsData: [AirportsData]) {
    airports = airportsData
    spinner.stops()
  }
}

// MARK: - Table View
extension FlightsVC {
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return airportsConnected.count
  }

  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: FlightsTVC.identifier,
                                             for: indexPath) as! FlightsTVC

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
    tableView.register(FlightsTVC.self,
                       forCellReuseIdentifier: FlightsTVC.identifier)
    tableView.tableFooterView = UIView()
  }

  /// Setup view title.
  ///
  func setupViewTitle() {
    title = Localized.flights

    navigationController?
      .navigationBar
      .prefersLargeTitles = true
  }

  /// Reload button shown when download from api failed.
  ///
  /// User can with it reload the data later manually.
  ///
  func populateReloadButton() {
    setupReloadButtonDesign()
    setupReloadButtonLayout()
  }

  /// Setup try again button design.
  ///
  func setupReloadButtonDesign() {
    reloadButton.backgroundColor = .accentColor$
    reloadButton.layer.cornerRadius = 8
    reloadButton.setTitle(Localized.tryAgain, for: .normal)
    reloadButton.titleLabel?.font =  .systemFont(ofSize: 20,
                                                 weight: .medium)
    reloadButton.addTarget(self, action: #selector(reloadButtonAction),
                           for: .touchUpInside)
    view.addSubview(reloadButton)
  }

  /// Restart the viewDidLoad downloading process for this view.
  ///
  @objc func reloadButtonAction() {
    reloadButton.removeFromSuperview()
    downloadData()
  }

  /// Setup try again button layout.
  ///
  func setupReloadButtonLayout() {
    reloadButton.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      // reload button
      //
      reloadButton
        .centerXAnchor
        .constraint(equalTo: view.centerXAnchor),

      reloadButton
        .centerYAnchor
        .constraint(equalTo: view.centerYAnchor),

      reloadButton
        .leadingAnchor
        .constraint(equalTo: view.leadingAnchor,
                    constant: 40),

      reloadButton
        .trailingAnchor
        .constraint(equalTo: view.trailingAnchor,
                    constant: -40),

      reloadButton
        .heightAnchor
        .constraint(equalToConstant: 50)
    ])
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
        style: .default) { _ in
        self.populateReloadButton()
      })

    present(alert, animated: true)
  }
}
