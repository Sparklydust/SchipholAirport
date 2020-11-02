//
//  AirlineTVC.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 02/11/2020.
//

import UIKit

//  MARK: AirlineTVC
/// Cell that populate airline link to Schiphol airport.
///
class AirlineTVC: UITableViewCell {

  /// Identifier for UITAbleView cell setup
  ///
  static let identifier = "airlineTVC"

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
extension AirlineTVC {
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
extension AirlineTVC {
  /// Setup nameLabel design.
  ///
  func setupNameLabel() {
    nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
    nameLabel.numberOfLines = 1
    nameLabel.textAlignment = .center
  }

  /// Setup distanceLabel design.
  ///
  func setupDistanceLabel() {
    distanceLabel.font = .systemFont(ofSize: 12, weight: .regular)
    distanceLabel.textColor = .systemGray
    distanceLabel.numberOfLines = 1
    distanceLabel.textAlignment = .center
  }
}

// MARK: - Layouts
extension AirlineTVC {
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
  /// First element in view anchored on top of view.
  ///
  func activateNameLabelLayout() {
    nameLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      nameLabel
        .topAnchor
        .constraint(equalTo: contentView.topAnchor,
                    constant: 16),

      nameLabel
        .leadingAnchor
        .constraint(equalTo: contentView.leadingAnchor,
                    constant: 16),

      nameLabel
        .trailingAnchor
        .constraint(equalTo: contentView.trailingAnchor,
                    constant: -16)
    ])
  }

  /// Layout distanceLabel.
  ///
  /// Underneath nameLabel.
  ///
  func activateDistanceLabelLayout() {
    distanceLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      distanceLabel
        .topAnchor
        .constraint(equalTo: nameLabel.bottomAnchor,
                    constant: 8),

      distanceLabel
        .leadingAnchor
        .constraint(equalTo: contentView.leadingAnchor,
                    constant: 16),

      distanceLabel
        .trailingAnchor
        .constraint(equalTo: contentView.trailingAnchor,
                    constant: -16),

      distanceLabel
        .bottomAnchor
        .constraint(equalTo: contentView.bottomAnchor,
                    constant: -16)
    ])
  }
}
