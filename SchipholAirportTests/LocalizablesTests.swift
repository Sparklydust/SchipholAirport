//
//  LocalizablesTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 28/10/2020.
//

import XCTest
@testable import SchipholAirport

class LocalizablesTests: XCTestCase {

  func testLocalized_airportsKey_Airports() throws {
    let expected = "Airports"
    
    XCTAssertEqual(expected, Localized.airports)
  }

  func testLocalized_flightsKey_Flights() throws {
    let expected = "Flights"

    XCTAssertEqual(expected, Localized.flights)
  }

  func testLocalized_airlinesKey_Airlines() throws {
    let expected = "Airlines"

    XCTAssertEqual(expected, Localized.airlines)
  }

  func testLocalized_downloadFailureTitle_ErrorWhenDownlading() {
    let expected = "Download Error"

    XCTAssertEqual(expected, Localized.downloadFailure)
  }

  func testLocalized_downloadFailureMessage_AnErrorOccured() {
    let expected = "There was an issue when loading the data. Please, try again later."

    XCTAssertEqual(expected, Localized.downloadFailureMessage)
  }

  func testLocalized_okButton_OK() {
    let expected = "OK"

    XCTAssertEqual(expected, Localized.ok)
  }

  func testLocalized_tryAgainButton_tryAgain() throws {
    let expected = "Try again"

    XCTAssertEqual(expected, Localized.tryAgain)
  }

  func testLocalized_kmUnit_km() throws {
    let expected = "km"

    XCTAssertEqual(expected, Localized.km)
  }

  func testLocalized_miUnit_mi() throws {
    let expected = "mi"

    XCTAssertEqual(expected, Localized.mi)
  }

  func testLocalized_kilometerUnit_kilometer() throws {
    let expected = "kilometers"

    XCTAssertEqual(expected, Localized.kilometers)
  }

  func testLocalized_milesUnit_miles() throws {
    let expected = "miles"

    XCTAssertEqual(expected, Localized.miles)
  }

  func testLocalized_settingsTabItem_returnsSettings() throws {
    let expected = "Settings"

    XCTAssertEqual(expected, Localized.settings)
  }

  func testLocalized_unitLabel_returnsUnit() throws {
    let expected = "Unit"

    XCTAssertEqual(expected, Localized.unit)
  }

  func testLocalized_detailsTitle_returnDetails() throws {
    let expected = "Details"

    XCTAssertEqual(expected, Localized.details)
  }

  func testLocalized_idLabel_returnID() throws {
    let expected = "airport id"

    XCTAssertEqual(expected, Localized.idLabel)
  }

  func testLocalized_latLabel_returnLatitutde() throws {
    let expected = "latitude"

    XCTAssertEqual(expected, Localized.latLabel)
  }

  func testLocalized_longLabel_returnLongitude() throws {
    let expected = "longitude"

    XCTAssertEqual(expected, Localized.longLabel)
  }

  func testLocalized_nameLabel_returnName() throws {
    let expected = "name"

    XCTAssertEqual(expected, Localized.nameLabel)
  }

  func testLocalized_cityLabel_returnCity() throws {
    let expected = "city"

    XCTAssertEqual(expected, Localized.cityLabel)
  }

  func testLocalized_countryIdLabel_returnCountryId() throws {
    let expected = "country id"

    XCTAssertEqual(expected, Localized.countryIdLabel)
  }

  func testLocalized_nearestAirportLabel_returnNearestAirport() throws {
    let expected = "nearest airport"

    XCTAssertEqual(expected, Localized.nearestAirportLabel)
  }

  func testLocalized_distanceAirportsLabel_returnDistanceBetweenAirports() throws {
    let expected = "distance between airports"

    XCTAssertEqual(expected, Localized.distanceAirportsLabel)
  }
}
