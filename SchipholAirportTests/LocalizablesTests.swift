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

  func testLocalized_milesUnit_ms() throws {
    let expected = "mi"

    XCTAssertEqual(expected, Localized.miles)
  }

  func testLocalized_settingsTabItem_returnsSettings() throws {
    let expected = "Settings"

    XCTAssertEqual(expected, Localized.settings)
  }
}
