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

  static let failure = NSLocalizedString(
    "failure", comment: "failure title to label data not showing in AirportDetailsVC")
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
    "km",
    comment: "kilometer unit shorten to km")

  static let mi = NSLocalizedString(
    "mi",
    comment: "miles unit shorten to mi")

  static let kilometers = NSLocalizedString(
    "kilometers",
    comment: "kilometers unit")

  static let miles = NSLocalizedString(
    "miles",
    comment: "miles unit")

  static let unit = NSLocalizedString(
    "unit",
    comment: "unit distance label in settings")

  static let details = NSLocalizedString(
    "details",
    comment: "label set as title in AirportDetailsVC")

  static let idLabel = NSLocalizedString(
    "idLabel",
    comment: "label for the airport id shown in AirportDetailsVC")

  static let latLabel = NSLocalizedString(
    "latLabel",
    comment: "label for the airport latitude shown in AirportDetailsVC")

  static let longLabel = NSLocalizedString(
    "longLabel",
    comment: "label for the airport longitude shown in AirportDetailsVC")

  static let nameLabel = NSLocalizedString(
    "nameLabel",
    comment: "label for the airport name shown in AirportDetailsVC")

  static let cityLabel = NSLocalizedString(
    "cityLabel",
    comment: "label for the airport city shown in AirportDetailsVC")

  static let countryIdLabel = NSLocalizedString(
    "countryIdLabel",
    comment: "label for the airport country shown in AirportDetailsVC")

  static let nearestAirportLabel = NSLocalizedString(
    "nearestAirportLabel",
    comment: "label for the nearest airport shown in AirportDetailsVC")

  static let distanceAirportsLabel = NSLocalizedString(
    "distanceAirportsLabel",
    comment: "label for the distance between airports shown in AirportDetailsVC")
}
