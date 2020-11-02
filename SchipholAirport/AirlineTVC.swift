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
  }

  required init?(coder: NSCoder) {
    return nil
  }
}
