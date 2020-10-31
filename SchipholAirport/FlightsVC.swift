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

  // Reference Types
  var flightsDownloader = NetworkRequest<FlightsData>(.flights)
  let spinner = Spinner()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainView()
    downloadData()
  }
}

// MARK: - Networking
extension FlightsVC {
  func downloadData() {
    downloadFlights()
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
}

// MARK: - Table View
extension FlightsVC {
  override func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
    return flights.count
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
