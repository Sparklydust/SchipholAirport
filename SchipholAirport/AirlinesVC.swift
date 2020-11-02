//
//  AirlinesVC.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 28/10/2020.
//

import UIKit

//  MARK: AirlinesVC
class AirlinesVC: UITableViewController {

  // Data
  var airlines = [AirlineData]()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupMainView()
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

    return cell
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
}
