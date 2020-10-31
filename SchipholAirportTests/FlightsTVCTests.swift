//
//  FlightsTVCTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 31/10/2020.
//

import XCTest
@testable import SchipholAirport

class FlightsTVCTests: XCTestCase {

  var sut: FlightsTVC!

  override func setUpWithError() throws {
    sut = FlightsTVC()
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }

  func testFlightsTVC_requiredInitWithCoder_returnsNil() throws {
    let flightTVC = FlightsTVC(coder: NSCoder())

    XCTAssertNil(flightTVC)
  }
}
