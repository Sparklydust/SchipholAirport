//
//  AirportsVCTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 28/10/2020.
//

import XCTest
@testable import SchipholAirport

class AirportsVCTests: XCTestCase {

  var sut: AirportsVC!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = AirportsVC()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
}

// MARK: - Tests
extension AirportsVCTests {
  func testAirportsVC_setupBackgroundColor_colorEqualToRed() throws {
    let expected = UIColor.red

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.view.backgroundColor)
  }

  func testAirportsVC_setupViewControllerTitle_titleEqualToAirports() throws {
    let expected = "Airports"

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.title)
  }
}
