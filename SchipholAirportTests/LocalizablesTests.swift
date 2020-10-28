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
}
