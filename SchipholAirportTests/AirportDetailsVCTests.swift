//
//  AirportDetailsVCTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 05/11/2020.
//

import XCTest
@testable import SchipholAirport

class AirportDetailsVCTests: XCTestCase {

  var sut: AirportDetailsVC!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = AirportDetailsVC()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
}

// MARK: - Tests
extension AirportDetailsVCTests {
  func testAirportDetailsVC_viewTitle_LocalizedDetails() throws {
    let expected = Localized.details

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.title)
  }
}
