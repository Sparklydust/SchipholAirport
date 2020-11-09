//
//  SettingsVCTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 01/11/2020.
//

import XCTest
@testable import SchipholAirport

class SettingsVCTests: XCTestCase {

  var sut: SettingsVC!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = SettingsVC()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
}

// MARK: - Tests
extension SettingsVCTests {
  func testSettingsVC_viewTitle_LocalizedSettings() throws {
    let expected = Localized.settings

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.title)
  }

  func testSettingsVC_segmentedControlItems_returnsKmAndMiles() throws {
    let expected = [
      Localized.kilometers,
      Localized.miles
    ]

    XCTAssertEqual(expected, sut.segContItems)
  }

  func testSettingsVC_segmentedControlAccessibilityIdentifier_returnSegContIdentifier() throws {
    let expected = "segContIdentifier"

    XCTAssertEqual(expected, SettingsVC.segContIdentifier)
  }

  func test() throws {
    let expected = SettingsVC.segContIdentifier
    sut.setupUnitSegementedControl()

    let result = sut.unitSegmentedControl.accessibilityIdentifier

    XCTAssertEqual(expected, result)
  }
}
