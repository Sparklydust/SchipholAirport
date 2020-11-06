//
//  AirportsVCTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 28/10/2020.
//

import XCTest
import CoreLocation
@testable import SchipholAirport

class AirportsVCTests: XCTestCase {

  var sut: AirportsVC!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = AirportsVC()

    sut.viewModel = MapViewModel(
      locationManager: MockCLLocationManager())
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
}

// MARK: - Tests
extension AirportsVCTests {
  func testAirportsVC_setupViewControllerTitle_titleEqualToAirports() throws {
    let expected = Localized.airports

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.title)
  }

  func testAirportsVC_modalViewNotification_returnDetailsModalNotification() throws {
    let expected = "detailsModalNotification"

    XCTAssertEqual(expected, AirportsVC.detailsModalNotification)
  }

  func testAirportsVC_AirportsDetailsNotification_returnAirportDetailsNotification() throws {
    let expected = "airportDetailsNotification"

    XCTAssertEqual(expected, AirportsVC.airportDetailsNotification)
  }
}
