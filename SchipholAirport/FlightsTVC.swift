//
//  FlightsTVC.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 30/10/2020.
//

import UIKit

//  MARK: FlightsTVC
/// Cell that populate flights connected to Schiphol.
///
class FlightsTVC: UITableViewCell {

  /// Identifier for UITAbleView cell setup
  static let identifier = "flightsTVC"

  var flightsLabel = UILabel()
  var distanceLabel = UILabel()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupMainView()
  }

  required init?(coder: NSCoder) {
    return nil
  }
}

// MARK: - Main Setup
extension FlightsTVC {
  /// Setup main view design and layout.
  ///
  func setupMainView() {
    addSubviews()
    setupFlightsLabel()
    setupDistanceLabel()
    activateLayoutConstraints()
  }

  /// Adding all subviews into FlightsTVC.
  ///
  func addSubviews() {
    contentView.addSubview(flightsLabel)
    contentView.addSubview(distanceLabel)
  }

  /// Setup flightsLabel design.
  ///
  func setupFlightsLabel() {
    flightsLabel.translatesAutoresizingMaskIntoConstraints = false
    flightsLabel.font = .systemFont(ofSize: 16, weight: .medium)
    flightsLabel.numberOfLines = 1
    distanceLabel.textAlignment = .left
  }

  /// Setup distanceLabel design.
  ///
  func setupDistanceLabel() {
    distanceLabel.translatesAutoresizingMaskIntoConstraints = false
    distanceLabel.font = .systemFont(ofSize: 12, weight: .regular)
    distanceLabel.textColor = .systemGray
    distanceLabel.numberOfLines = 1
    distanceLabel.textAlignment = .right
  }

  /// Setup and activate all layout of the FlightsTVC.
  ///
  /// Elements are set in NSLayoutConstraint.activate()from top to
  /// bottom. Comments are added in func to define which view
  /// element is being anchored.
  ///
  func activateLayoutConstraints() {
    NSLayoutConstraint.activate([
      // flightsLabel
      flightsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      flightsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                            constant: 16),
      flightsLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                        constant: 16),
      // distanceLabel
      distanceLabel.centerYAnchor.constraint(equalTo: flightsLabel.centerYAnchor),
      distanceLabel.leadingAnchor.constraint(greaterThanOrEqualToSystemSpacingAfter: flightsLabel.trailingAnchor, multiplier: 8),
      distanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                              constant: -16)
    ])
  }
}
