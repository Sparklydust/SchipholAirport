//
//  AirlinesVC.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 28/10/2020.
//

import UIKit

//  MARK: AirlinesVC
class AirlinesVC: UITableViewController {

  // UI
  var alert = UIAlertController()
  var tryAgainButton = UIButton()

  // Data
  var airlines = [AirlineData]()
  var flights = [FlightData]()
  var airports = [AirportData]()

  // Reference Types
  let spinner = Spinner()
  var airlinesDownloader = NetworkRequest<AirlineData>(.airlines)
  var flightsDownloader = NetworkRequest<FlightData>(.flights)
  var airportsDownloader = NetworkRequest<AirportData>(.airports)

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainView()
    downloadData()
  }
}
// MARK: - Networking
extension AirlinesVC {
  /// Download all data for the view.
  ///
  /// Airlines, Flights and Airports are being fetch from the api.
  /// The completion with @escaping isused to pass expectation
  /// in tests mainly.
  ///
  func downloadData(_ completion: @escaping () -> Void = { }) {
    downloadAirlines(completion)
    downloadFlights(completion)
    downloadAirports(completion)
  }

  /// Download airlines from flightassets api.
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
          completion()
        }
        return
      }
    }
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
    spinner.stops()
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
    tableView.reloadData()
  }
}

// MARK: - Table View
extension AirlinesVC {
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return airlines.count
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
  }

  /// Setup cell with airlines informations.
  ///
  /// Cell is populated once the airports connected flights
  /// with airlines are fetched from api and trimmed.
  ///
  func setup(_ cell: AirlineTVC, at indexPath: IndexPath) -> AirlineTVC {
    let airline = airlines[indexPath.row]

    cell.nameLabel.text = airline.name

    return cell
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
