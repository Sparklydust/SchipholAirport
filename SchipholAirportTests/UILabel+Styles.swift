//
//  UILabel+Styles.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 05/11/2020.
//

import UIKit

//  MARK: UILabel+Styles
/// Define style for a same style of UILabel
/// elements in a view.
///
extension UILabel {
  /// Secondary static label style.
  ///
  func secondaryLabelStyle(text: String) {
    self.text = text
    self.textColor = .systemGray
    self.font = .systemFont(ofSize: 16,
                            weight: .medium)
  }

  /// Style for first class data to show to user.
  ///
  func dataLabelStyle() {
    self.textColor = .black$White
    self.font = .systemFont(ofSize: 20, weight: .regular)
  }
}
