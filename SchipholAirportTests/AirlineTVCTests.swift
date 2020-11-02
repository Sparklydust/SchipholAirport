//
//  AirlineTVCTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 02/11/2020.
//

import XCTest
@testable import SchipholAirport

class AirlineTVCTests: XCTestCase {

  var sut: AirlineTVC!

  override func setUpWithError() throws {
    sut = AirlineTVC()
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
}

// MARK: - Tests
extension AirlineTVCTests {
  func testAirlineTVC_cellIdentifier_returnAirlineTVC() throws {
    let expected = "airlineTVC"

    XCTAssertEqual(expected, AirlineTVC.identifier)
  }

  func testAirlineTVC_requiredInitWithCoder_returnsNil() throws {
    let airlineTVC = AirlineTVC(coder: NSCoder())

    XCTAssertNil(airlineTVC)
  }
}
