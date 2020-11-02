//
//  FlightTVC.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 30/10/2020.
//

import UIKit

//  MARK: FlightTVC
/// Cell that populate flights connected to Schiphol.
///
class FlightTVC: UITableViewCell {

  /// Identifier for UITAbleView cell setup
  ///
  static let identifier = "flightTVC"

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
extension FlightTVC {
  /// Setup main view design and layout.
  ///
  func setupMainView() {
    setupDesign()
    addSubviews()
    activateLayoutConstraints()
  }

  /// Setup view design on all elements.
  ///
  func setupDesign() {
    setupNameLabel()
    setupDistanceLabel()
  }

  /// Adding all subviews into FlightTVC.
  ///
  func addSubviews() {
    contentView.addSubview(nameLabel)
    contentView.addSubview(distanceLabel)
  }
}

// MARK: - Design
extension FlightTVC {
  /// Setup nameLabel design.
  ///
  func setupNameLabel() {
    nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
    nameLabel.numberOfLines = 1
    distanceLabel.textAlignment = .left
  }

  /// Setup distanceLabel design.
  ///
  func setupDistanceLabel() {
    distanceLabel.font = .systemFont(ofSize: 12, weight: .regular)
    distanceLabel.textColor = .systemGray
    distanceLabel.numberOfLines = 1
    distanceLabel.textAlignment = .right
  }
}

// MARK: - Layouts
extension FlightTVC {
  /// Setup and activate all layouts of the FlightsTVC.
  ///
  /// Elements are set from top to bottom.
  ///
  func activateLayoutConstraints() {
    activateNameLabelLayout()
    activateDistanceLabelLayout()
  }

  /// Layout nameLabel.
  ///
  /// First element in view anchored from centerY of view.
  ///
  func activateNameLabelLayout() {
    nameLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
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
    ])
  }

  /// Layout distanceLabel.
  ///
  /// Center to nameLabel Y axis
  ///
  func activateDistanceLabelLayout() {
    distanceLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
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
