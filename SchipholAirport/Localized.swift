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

// MARK: - Tab Bar
extension Localized {
  static let airports = NSLocalizedString(
    "airports",
    comment: "airport tab bar name")

  static let flights = NSLocalizedString(
    "flights",
    comment: "flights tab bar name")

  static let airlines = NSLocalizedString(
    "airlines",
    comment: "airlines tab bar name")

  static let settings = NSLocalizedString(
    "settings",
    comment: "settings tab bar name")
}

// MARK: - Buttons
extension Localized {
  static let ok = NSLocalizedString(
    "ok",
    comment: "classic ok button name")

  static let tryAgain = NSLocalizedString(
    "tryAgain",
    comment: "try again button title when api call failed")
}

// MARK: - Error Titles
extension Localized {
  static let downloadFailure = NSLocalizedString(
    "downloadFailure",
    comment: "error title when downlad from api failed")
}

// MARK: - Error messages
extension Localized {
  static let downloadFailureMessage = NSLocalizedString(
    "downloadFailureMessage",
    comment: "message shown to user when downlad from api failed")
}

// MARK: - UILabels
extension Localized {
  static let km = NSLocalizedString(
    "km", comment: "kilometer unit shorten to km")

  static let mi = NSLocalizedString(
    "mi", comment: "miles unit shorten to mi")

  static let kilometers = NSLocalizedString(
    "kilometers", comment: "kilometers unit")

  static let miles = NSLocalizedString(
    "miles", comment: "miles unit")

  static let unit = NSLocalizedString(
    "unit", comment: "unit distance label in settings")
}
