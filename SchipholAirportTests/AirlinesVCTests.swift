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
  func testAirlinesVC_setupViewControllerTitle_titleEqualAirlines() throws {
    let expected = Localized.airlines

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.title)
  }

  func testAirlinesVC_airlinesVariableOfAirlineData_mustBeAnEmptyArrayAtStart() throws {
    let expected = [AirlineData]()

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.airlines)
  }

  func testAirlinesVC_checkIfTableViewExists_returnNotNil() throws {
    sut.loadViewIfNeeded()

    XCTAssertNotNil(sut.tableView)
  }

  func testAirlinesVC_tableViewHasDelegate_returnNotNil() throws {
    XCTAssertNotNil(sut.tableView.delegate)
  }

  func testAirlinesVC_checkTableViewNumberOfRows_returnAirlinesArrayCount() throws {
    let expected = sut.airlines.count

    sut.loadViewIfNeeded()
    let result = sut.tableView(sut.tableView, numberOfRowsInSection: 0)

    XCTAssertEqual(expected, result)
  }
}
