//
//  LocationProviderTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 04/11/2020.
//

import XCTest
import CoreLocation
@testable import SchipholAirport

class LocationProviderTests: XCTestCase {

  var sut: LocationProvider!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = LocationProvider(
      locationManager: MockCLLocationManager(),
      mapView: MockMKMapView())
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
}

extension LocationProviderTests {
  func testLocationProvider_setupLocationManagerDelegate_returnNotNit() throws {
    sut.setupLocationManager()

    XCTAssertNotNil(sut.locationManager.delegate)
  }

  func testLocationProvider_setupDesiredAccuracy_returnAccuracyBest() throws {
    let expected = kCLLocationAccuracyBest

    sut.setupLocationManager()
    let result = sut.locationManager.desiredAccuracy

    XCTAssertEqual(expected, result)
  }

  func testLocationProvider_allowsBackgroundLocationUpdates_returnFalse() throws {
    let expected = true
    let result = sut.locationManager.allowsBackgroundLocationUpdates

    XCTAssertEqual(expected, result)
  }

  func testLocationProvider_aroundUserDistance_returnFiftyThousand() throws {
    let expected: CLLocationDistance = 500000

    XCTAssertEqual(expected, sut.aroundUserDistance)
  }
}
