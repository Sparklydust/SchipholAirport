//
//  FlightsVC.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 28/10/2020.
//

import UIKit
import CoreLocation

//  MARK: FlightsVC
/// View that populates flights connected to Schiphol.
///
class FlightsVC: UITableViewController {

  // UI
  var alert = UIAlertController()
  var tryAgainButton = UIButton()

  // Data
  var flights = [FlightData]()
  var flightsConnected = [FlightData]()
  var airports = [AirportData]()
  var airportsConnected = [AirportData]()

  // Reference Types
  var flightsDownloader = NetworkRequest<FlightData>(.flights)
  var airportsDownloader = NetworkRequest<AirportData>(.airports)
  let spinner = Spinner()

  // Constants
  let distanceFormat = "%.2f %@"
  let schipholAirportID = "AMS"
  let schipholLocation = CLLocation(latitude: 52.30907,
                                    longitude: 4.763385)

  // Variables
  var isInKm = UserDefaultsService.shared.isInKm
  var trackIsInKm = !UserDefaultsService.shared.isInKm

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainView()
    downloadData()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    checkDistanceUnitSettings()
  }
}

// MARK: - Algorithms
extension FlightsVC {
  /// Filter flights and then airports connected to
  /// Schiphol airport.
  ///
  /// - Warning: Order set in this func is important.
  ///
  func populateAirports() {
    filterFlightsFromSchiphol()
    filterAirportsConnectedToSchiphol()
    sortConnectedAirports()
  }

  /// Filter flights fetch from api that are connected
  /// to Schiphol airport.
  ///
  /// Arrival airport that are duplicated are being removed
  /// from the updated flightsConnected variable.
  ///
  func filterFlightsFromSchiphol() {
    _ = flights
      .filter { $0.departureAirportId == schipholAirportID }
      .map { flight in
        if !flightsConnected.contains(
            where: { $0.arrivalAirportId == flight.arrivalAirportId }) {
          flightsConnected.append(flight)
        }
      }
  }

  /// Filter airports fetch from api with flights connected
  /// to Schiphol airport.
  ///
  /// Duplicated airports are being removed using their id.
  ///
  func filterAirportsConnectedToSchiphol() {
    _ = airports
      .compactMap { airport in
        for f in flightsConnected {
          if f.arrivalAirportId == airport.id {
            if !airportsConnected.contains(where: { $0.id == airport.id }) {
              airportsConnected.append(airport)
            }
          }
        }
      }
  }

  /// Sort airports in ascending distance from Schiphol airport.
  ///
  func sortConnectedAirports() {
    airportsConnected
      .sort {
        $0.distance(isInKm, to: schipholLocation)
          < $1.distance(isInKm, to: schipholLocation)
      }
  }

  /// User distance unit set in settings.
  ///
  /// Value are being saved and retrieve in
  /// UserDefaults.
  ///
  func checkDistanceUnitSettings() {
    isInKm = UserDefaultsService.shared.isInKm
    if trackIsInKm == isInKm {
      downloadData()
      trackIsInKm = !UserDefaultsService.shared.isInKm
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
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.handleDownloadFailure()
          completion()
        }
        return
      case .success(let flights):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
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
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.handleDownloadFailure()
          completion()
        }
        return
      case .success(let airports):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
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
  func handleDownloadSuccess(_ flightsData: [FlightData]) {
    flights = flightsData
    spinner.stops()
  }

  /// Handling downloading airports data success from api call.
  ///
  func handleDownloadSuccess(_ airportsData: [AirportData]) {
    airports = airportsData
    spinner.stops()
    populateAirports()
    tableView.reloadData()
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

    let cell = tableView.dequeueReusableCell(withIdentifier: FlightTVC.identifier,
                                             for: indexPath) as! FlightTVC

    return setup(cell, at: indexPath)
  }
}

// MARK: - FlightsVC Setup
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
    tableView.register(FlightTVC.self,
                       forCellReuseIdentifier: FlightTVC.identifier)
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

  /// Setup cell with airports informations.
  ///
  /// Cell is populated once the airports connected flights
  /// from api are fetched and trimmed.
  ///
  func setup(_ cell: FlightTVC, at indexPath: IndexPath) -> FlightTVC {
    let airport = airportsConnected[indexPath.row]
    let distance = distanceFromSchiphol(to: airport)

    cell.nameLabel.text = airport.name
    cell.distanceLabel.text = distance

    return cell
  }

  /// Calculate the distance between two airports.
  ///
  /// - Parameters:
  ///     - airport: airport populated in cell.
  /// - Returns: String value with distance and unit
  ///
  func distanceFromSchiphol(to airport: AirportData) -> String {
    let distance = airport.distance(isInKm, to: schipholLocation)
    let unit = isInKm ? Localized.km : Localized.mi
    let airportDistance = String(format: distanceFormat, distance, unit)
    return airportDistance
  }

  /// Try again button shown when download from api failed.
  ///
  /// User can with it reload the data later manually.
  ///
  func populateTryAgainButton() {
    setupTryAgainButtonDesign()
    setupTryAgainButtonLayout()
  }

  /// Setup try again button design.
  ///
  func setupTryAgainButtonDesign() {
    tryAgainButton.backgroundColor = .accentColor$
    tryAgainButton.layer.cornerRadius = 8
    tryAgainButton.setTitle(Localized.tryAgain, for: .normal)
    tryAgainButton.titleLabel?.font =  .systemFont(ofSize: 20,
                                                 weight: .medium)
    tryAgainButton.addTarget(self, action: #selector(tryAgainButtonAction),
                           for: .touchUpInside)
    view.addSubview(tryAgainButton)
  }

  /// Restart the viewDidLoad downloading process for this view.
  ///
  @objc func tryAgainButtonAction() {
    tryAgainButton.removeFromSuperview()
    downloadData()
  }
}

// MARK: - Autolayouts
extension FlightsVC {
  /// Layout tryAgainButton.
  ///
  func setupTryAgainButtonLayout() {
    tryAgainButton.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      tryAgainButton
        .centerXAnchor
        .constraint(equalTo: view.centerXAnchor),

      tryAgainButton
        .centerYAnchor
        .constraint(equalTo: view.centerYAnchor),

      tryAgainButton
        .leadingAnchor
        .constraint(equalTo: view.leadingAnchor,
                    constant: 40),

      tryAgainButton
        .trailingAnchor
        .constraint(equalTo: view.trailingAnchor,
                    constant: -40),

      tryAgainButton
        .heightAnchor
        .constraint(equalToConstant: 50)
    ])
  }
}

// MARK: - Alerts
extension FlightsVC {
  /// Alert with message to user when download failed.
  ///
  /// A simple ok button to dismiss the alert is added
  /// and when tapped, try again button is populated on view.
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
        self.populateTryAgainButton()
      })

    present(alert, animated: true)
  }
}
