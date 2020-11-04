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

    sut.airportsDownloader.resourceSession =
      MockURLSession(data: FakeDataResponse.airportsCorrectData,
                     response: FakeDataResponse.response200OK,
                     error: nil)
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

  func testLocationProvider_airportsDataArrayEmptyAtInitialization_ReturnEmptyAirportDataArray() throws {
    let expected = [AirportData]()

    XCTAssertEqual(expected, sut.airports)
  }

  func testLocationProvider_getAllAirportsFromAPI_returnsFailure() throws {
    let expected = 0

    let expectation = XCTestExpectation(
      description: "Failure from api call")

    sut.airportsDownloader.resourceSession =
      MockURLSession(
        data: FakeDataResponse.incorrectData,
        response: FakeDataResponse.responseKO,
        error: nil)

    sut.downloadAirports() { expectation.fulfill() }

    wait(for: [expectation], timeout: 1)
    XCTAssertEqual(expected, sut.airports.count)
  }

  func testLocationProvider_getAllAirportsFromAPI_returnsSuccess() throws {
    let expected = 13

    let expectation = XCTestExpectation(
      description: "Success with airports from api in an array")

    sut.airportsDownloader.resourceSession =
      MockURLSession(
        data: FakeDataResponse.airportsCorrectData,
        response: FakeDataResponse.response200OK,
        error: nil)

    sut.downloadAirports() { expectation.fulfill() }

    wait(for: [expectation], timeout: 1)
    XCTAssertEqual(expected, sut.airports.count)
  }
}
