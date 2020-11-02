//
//  AirportDataTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 02/11/2020.
//

import XCTest
import CoreData
@testable import SchipholAirport

class AirportDataTests: XCTestCase {

  var sut: AirportData!

  var schipholLocation: CLLocation!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = AirportData(
      id: "CDG",
      latitude: 49.003197,
      longitude: 2.567023,
      name: "Charles De Gaulle Airport",
      city: "Paris",
      countryId: "FR")

    schipholLocation = CLLocation(
      latitude: 52.30907,
      longitude: 4.763385)
  }

  override func tearDownWithError() throws {
    schipholLocation = nil
    sut = nil
    try super.tearDownWithError()
  }
}

// MARK: - Tests
extension AirportDataTests {
  func testAirportData_calculateDistanceInKmBetweenParisAndAmsterdam_returnCorrectDistance() {
    let expected = CLLocationDistance(399.15)

    let result = sut.distance(true, to: schipholLocation)

    XCTAssertEqual(expected, result, accuracy: 0.01)
  }

  func testAirportData_calculateDistanceInMilesBetweenParisAndAmsterdam_returnCorrectDistance() {
    let expected = CLLocationDistance(248.02)

    let result = sut.distance(false, to: schipholLocation)

    XCTAssertEqual(expected, result, accuracy: 0.01)
  }
}
