//
//  FlightsVCTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 28/10/2020.
//

import XCTest
@testable import SchipholAirport

class FlightsVCTests: XCTestCase {

  var sut: FlightsVC!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = FlightsVC()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func testFlightsVC_setupBackgroundColor_colorEqualToBlue() throws {
    let expected = UIColor.blue

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.view.backgroundColor)
  }

  func testFlightsVC_setupViewControllerTitle_titleEqualToFlights() throws {
    let expected = "Flights"

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.title)
  }
}
