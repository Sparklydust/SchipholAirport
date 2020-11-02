//
//  UserDefaultsContainerTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 02/11/2020.
//

import XCTest
@testable import SchipholAirport

class UserDefaultsContainerTests: XCTestCase {

  var sut: UserDefaultsContainer!

  override func setUpWithError() throws {
    sut = UserDefaultsContainer()
    try super.setUpWithError()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
}

// MARK: - Tests
extension UserDefaultsContainerTests {
  func testUserDefaultsContainer_isInKmContainerInitializeAtStart_returnTrue() throws {
    let expected = true

    XCTAssertEqual(expected, sut.isInKm)
  }

  func testUserDefaultsContainer_keyForIsInKm_isInKm() {
    let expected = "isInKm"

    XCTAssertEqual(expected, UserDefaultsContainer.Key.isInKm)
  }
}
