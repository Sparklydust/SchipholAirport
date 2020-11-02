//
//  UserDefaultsServiceTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 02/11/2020.
//

import XCTest
@testable import SchipholAirport

class UserDefaultsServiceTests: XCTestCase {

  var sut: UserDefaultsService!
  var mockUserDefaultsContainer: MockUserDefaultsContainer!

  override func setUpWithError() throws {
    try super.setUpWithError()
    mockUserDefaultsContainer = MockUserDefaultsContainer()
    sut = UserDefaultsService(userDefaultsContainer: mockUserDefaultsContainer)
  }

  override func tearDownWithError() throws {
    sut = nil
    mockUserDefaultsContainer = nil
    try super.tearDownWithError()
  }
}

// MARK: - Tests
extension UserDefaultsServiceTests {
  func testUserDefaultsService_saveIsInKmToTrue_ReturnTrue() throws {
    sut.isInKm = true

    let result = sut.isInKm

    XCTAssertTrue(result)
  }

  func testUserDefaultsService_saveIsInKmToFalse_ReturnFalse() throws {
    sut.isInKm = false

    let result = sut.isInKm

    XCTAssertFalse(result)
  }
}
