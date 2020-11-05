//
//  UIStackView+Styles.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 05/11/2020.
//

import UIKit

//  MARK: UIStackView+Styles
/// Define custom style for stack views.
///
extension UIStackView {
  /// Secondary style for stack views inside
  /// main stack view in AirportDetailsVC.
  ///
  func setSecondaryStackStyle() {
    self.axis = .vertical
    self.distribution = .equalSpacing
    self.alignment = .center
    self.spacing = 4
  }
}
