//
//  AirlinesVCTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 28/10/2020.
//

import XCTest
@testable import SchipholAirport

class AirlinesVCTests: XCTestCase {

  var sut: AirlinesVC!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = AirlinesVC()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
}

// MARK: - Tests
extension AirlinesVCTests {
  func testAirlinesVC_setupBackgroundColor_colorEqualToGreen() throws {
    let expected = UIColor.green

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.view.backgroundColor)
  }

  func testAirlinesVC_setupViewControllerTitle_titleEqualAirlines() throws {
    let expected = "Airlines"

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.title)
  }
}
