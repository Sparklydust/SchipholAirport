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

  var nameLabel = UILabel()
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
    setupNameLabel()
    setupDistanceLabel()
    activateLayoutConstraints()
  }

  /// Adding all subviews into FlightsTVC.
  ///
  func addSubviews() {
    contentView.addSubview(nameLabel)
    contentView.addSubview(distanceLabel)
  }

  /// Setup nameLabel design.
  ///
  func setupNameLabel() {
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
    nameLabel.numberOfLines = 1
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

      // nameLabel
      //
      nameLabel
        .centerYAnchor
        .constraint(equalTo: contentView.centerYAnchor),

      nameLabel
        .leadingAnchor
        .constraint(equalTo: contentView.leadingAnchor,
                    constant: 16),

      nameLabel
        .topAnchor
        .constraint(equalTo: contentView.topAnchor,
                    constant: 16),

      // distanceLabel
      //
      distanceLabel
        .centerYAnchor
        .constraint(equalTo: nameLabel.centerYAnchor),

      distanceLabel
        .leadingAnchor
        .constraint(greaterThanOrEqualToSystemSpacingAfter: nameLabel.trailingAnchor,
                    multiplier: 1),

      distanceLabel
        .trailingAnchor
        .constraint(equalTo: contentView.trailingAnchor,
                    constant: -16),

      distanceLabel
        .widthAnchor
        .constraint(equalToConstant: 75)
    ])
  }
}
