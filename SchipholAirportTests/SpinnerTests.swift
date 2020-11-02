//
//  SpinnerTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 31/10/2020.
//

import XCTest
@testable import SchipholAirport

class SpinnerTests: XCTestCase {

  var sut: Spinner!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = Spinner()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
}

// MARK: - Tests
extension SpinnerTests {
  func testSpinner_isAnimating_returnsTrue() throws {
    sut.starts(on: UIView())

    XCTAssertTrue(sut.activityIndicator.isAnimating == true)
  }

  func testSpinner_isAnimating_returnFalse() throws {
    sut.stops()

    XCTAssertFalse(sut.activityIndicator.isAnimating == true)
  }
}
