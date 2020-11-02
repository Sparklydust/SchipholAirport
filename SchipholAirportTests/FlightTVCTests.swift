//
//  FlightTVCTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 31/10/2020.
//

import XCTest
@testable import SchipholAirport

class FlightTVCTests: XCTestCase {

  var sut: FlightTVC!

  override func setUpWithError() throws {
    sut = FlightTVC()
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
}

// MARK: - Tests
extension FlightTVCTests {
  func testFlightTVC_cellIdentifier_returnFlightTVC() throws {
    let expected = "flightTVC"

    XCTAssertEqual(expected, FlightTVC.identifier)
  }

  func testFlightTVC_requiredInitWithCoder_returnsNil() throws {
    let flightTVC = FlightTVC(coder: NSCoder())

    XCTAssertNil(flightTVC)
  }
}
