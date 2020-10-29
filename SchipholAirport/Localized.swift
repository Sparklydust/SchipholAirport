//
//  Localized.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 28/10/2020.
//

import Foundation

//  MARK: Localized
/// Enumeration of localized Strings for translations.
///
/// This enum is the link between all the code String
/// declarations and the Localizable.strings keys to
/// perform the translations.
///
/// ```
/// Localized.airports // example of use
/// ```
enum Localized {}

extension Localized {

  static let airports = NSLocalizedString("airports", comment: "airport tab bar name")
  static let flights = NSLocalizedString("flights", comment: "flights tab bar name")
  static let airlines = NSLocalizedString("airlines", comment: "airlines tab bar name")
}
