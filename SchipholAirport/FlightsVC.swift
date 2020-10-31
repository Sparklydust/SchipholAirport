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

  var flights = [FlightsData]()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainView()
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
