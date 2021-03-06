//
//  AirlinesVC.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 28/10/2020.
//

import UIKit
import CoreLocation

//  MARK: AirlinesVC
class AirlinesVC: UITableViewController {

  // UI
  var alert = UIAlertController()
  var tryAgainButton = UIButton()

  // Data
  var airlines = [AirlineData]()
  var airlinesConnected = [AirlineData]()
  var airlinesDictionary = [AirlineData: Double]()
  var airlinesSorted = [Dictionary<AirlineData, Double>.Element]()
  var flights = [FlightData]()
  var flightsConnected = [FlightData]()
  var airports = [AirportData]()

  // Reference Types
  let spinner = Spinner()
  var airlinesDownloader = NetworkRequest<AirlineData>(.airlines)
  var flightsDownloader = NetworkRequest<FlightData>(.flights)
  var airportsDownloader = NetworkRequest<AirportData>(.airports)

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
extension AirlinesVC {
  /// Filter flights, airlines and airports distance from
  /// Schiphol airport.
  ///
  /// - Warning: Order set in this func is very important.
  ///
  func populateAirlines() {
    filterFlightsFromSchiphol()
    filterAirlinesFromSchiphol()
    setAirlinesConnectedDictionary()
    calculateAirlinesDistance()
    sortAirlinesByDistance()
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
      .map { flightsConnected.append($0) }
  }

  /// Filter airlines fetch from api that are leaving
  /// Schiphol airport.
  ///
  /// Airlines that are duplicated are being removed
  /// from the updated airlinesConnected variable.
  ///
  func filterAirlinesFromSchiphol() {
    _ = airlines.compactMap { filterConnected($0) }
  }

  /// Create a dictionary of airlines connected with
  /// distance as value.
  ///
  func setAirlinesConnectedDictionary() {
    _ = flightsConnected
      .compactMap { flight in
        setAirlinesDictionary(from: flight)
      }
  }

  /// Calculate distance of all airline flights.
  ///
  /// Distance of each airline are added as a value in
  /// the airlinesDictionary.
  ///
  func calculateAirlinesDistance() {
    _ = airlinesDictionary
      .compactMap { airline, distance in
        calculate(airline, distance)
      }
  }

  /// Filter Schiphol connected airlines from all api airlines data.
  ///
  /// Airline that are duplicated are being removed
  /// from the updated airlinesConnected variable.
  ///
  func filterConnected(_ airline: AirlineData) {
    for f in flightsConnected {
      if f.airlineId == airline.id {
        if !airlinesConnected.contains(where: { $0.id == airline.id }) {
          airlinesConnected.append(airline)
        }
      }
    }
  }

  /// Set dictionary of airline with a value of distance associated.
  ///
  /// airlines connected that are dubplicated are being removed
  /// from the updated airlinesDictionary variable.
  ///
  func setAirlinesDictionary(from flight: FlightData) {
    for a in airlinesConnected {
      if a.id == flight.airlineId {
        if !airlinesDictionary.contains(where: { $0.key.id == a.id }) {
          airlinesDictionary[a] = .zero
        }
      }
    }
  }

  /// Calculate the distance done for the airline.
  ///
  /// All flights of the airline leaving Schiphol are
  /// being added to calculate the total of all.
  ///
  func calculate(_ airline: AirlineData, _ distance: CLLocationDistance) {
    var distance = distance
    for f in flightsConnected {
      if f.airlineId == airline.id {
        for a in airports {
          if a.id == f.arrivalAirportId
              && f.airlineId == airline.id {
            distance += a.distance(isInKm, to: schipholLocation)
            airlinesDictionary[airline] = distance
          }
        }
      }
    }
  }

  /// User distance unit set in settings.
  ///
  /// Value are being saved and retrieve in UserDefaults.
  ///
  func checkDistanceUnitSettings() {
    isInKm = UserDefaultsService.shared.isInKm
    if trackIsInKm == isInKm {
      reinitAirlinesFlightsValues()
      downloadData()
      trackIsInKm = !UserDefaultsService.shared.isInKm
    }
  }

  /// Sort airlines by distance to Schiphol airport.
  ///
  /// The order is set to be ascending from the dictionary
  /// value that represent the distance.
  ///
  func sortAirlinesByDistance() {
    airlinesSorted = airlinesDictionary.sorted { $0.1 < $1.1 }
  }
}


// MARK: - Networking
extension AirlinesVC {
  /// Download all data for the view.
  ///
  /// Airlines, Flights and Airports are being fetch from the api.
  /// The completion with @escaping issued to pass expectation
  /// in tests mainly.
  ///
  func downloadData(_ completion: @escaping () -> Void = { }) {
    downloadAirlines(completion)
  }

  /// Download airlines from flight assets api.
  ///
  /// The completion with @escaping is used to pass expectation
  /// in tests mainly.
  ///
  func downloadAirlines(_ completion: @escaping () -> Void = { }) {
    spinner.starts(on: view)

    airlinesDownloader.getArray { response in
      switch response {
      case .failure:
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.handleDownloadFailure()
          completion()
        }
        return
      case .success(let airlines):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.handleDownloadSuccess(airlines)
          self.downloadFlights(completion)
        }
        return
      }
    }
  }

  /// Download flights from flight assets api.
  ///
  /// The completion with @escaping is used to pass expectation
  /// in tests mainly.
  ///
  func downloadFlights(_ completion: @escaping () -> Void = { }) {
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
          self.downloadAirports(completion)
        }
        return
      }
    }
  }

  /// Download airports from flight assets api.
  ///
  /// The completion with @escaping is used to pass expectation
  /// in tests mainly.
  ///
  func downloadAirports(_ completion: @escaping () -> Void = { }) {
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

  /// Handling downloading failure from api call.
  ///
  /// Populate an alert to the user with a try again button.
  ///
  func handleDownloadFailure() {
    spinner.stops()
    showDownloadFailureAlert()
  }

  /// Handling downloading airlines data success from api call.
  ///
  func handleDownloadSuccess(_ airlinesData: [AirlineData]) {
    airlines = airlinesData
  }

  /// Handling downloading flights data success from api call.
  ///
  func handleDownloadSuccess(_ flightsData: [FlightData]) {
    flights = flightsData
  }

  /// Handling downloading airports data success from api call.
  ///
  func handleDownloadSuccess(_ airportsData: [AirportData]) {
    airports = airportsData
    populateAirlines()
    spinner.stops()
    tableView.reloadData()
  }
}

// MARK: - Table View
extension AirlinesVC {
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return airlinesSorted.count
  }

  override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCell(withIdentifier: AirlineTVC.identifier,
                                             for: indexPath) as! AirlineTVC

    return setup(cell, at: indexPath)
  }
}

// MARK: - AirlinesVC Setup
extension AirlinesVC {
  /// Main setup.
  ///
  func setupMainView() {
    setupViewTitle()
    setupTableView()
  }

  /// Set airlinesDictionary and FlightsConnected to
  /// empty values.
  ///
  /// Used to re-download data when user has change unit
  /// from settings.
  ///
  func reinitAirlinesFlightsValues() {
    airlinesDictionary = [AirlineData: Double]()
    flightsConnected = [FlightData]()
  }
}

// MARK: - Design
extension AirlinesVC {
  /// Setup view title.
  ///
  func setupViewTitle() {
    title = Localized.airlines

    navigationController?
      .navigationBar
      .prefersLargeTitles = true
  }

  /// Setup table view style and cell type.
  ///
  func setupTableView() {
    tableView.register(AirlineTVC.self,
                       forCellReuseIdentifier: AirlineTVC.identifier)
    tableView.tableFooterView = UIView()
    tableView.allowsSelection = false
  }

  /// Setup cell with sorted airlines informations.
  ///
  /// Cell is populated once the airports connected flights
  /// with airlines are fetched from api and trimmed.
  ///
  func setup(_ cell: AirlineTVC, at indexPath: IndexPath) -> AirlineTVC {

    let airline = airlinesSorted[indexPath.row]
    let distance = distanceAllFlights(airline.value)

    cell.nameLabel.text = airline.key.name
    cell.distanceLabel.text = distance

    return cell
  }

  /// Calculate the distance done for all flights of one airline.
  ///
  /// - Parameters:
  ///     - distance: distance from airline dictionary value.
  /// - Returns: String value with distance and unit
  ///
  func distanceAllFlights(_ distance: CLLocationDistance) -> String {
    let unit = isInKm ? Localized.km : Localized.mi
    let flightsDistance = String(format: distanceFormat, distance, unit)
    return flightsDistance
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
extension AirlinesVC {
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
extension AirlinesVC {
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
