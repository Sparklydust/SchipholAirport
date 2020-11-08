//
//  MapViewModelTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 04/11/2020.
//

import XCTest
import CoreLocation
import MapKit
@testable import SchipholAirport

class MapViewModelTests: XCTestCase {

  var sut: MapViewModel!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = MapViewModel(
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

// MARK: - Helpers
extension MapViewModelTests {
  /// Load fake airports data from json file inside Fakes/Json folder.
  ///
  func loadFakeJsonAirports() -> [AirportData] {
    let bundle = Bundle(for: MapViewModelTests.self)
    let url = bundle.url(forResource: "Airports", withExtension: "json")
    let data = try! Data(contentsOf: url!)

    let airports = try! JSONDecoder().decode([AirportData].self, from: data)
    return airports
  }
}

// MARK: - Tests
extension MapViewModelTests {
  func testMapViewModel_setupLocationManagerDelegate_returnNotNit() throws {
    sut.setupLocationManager()

    XCTAssertNotNil(sut.locationManager.delegate)
  }

  func testMapViewModel_setupDesiredAccuracy_returnAccuracyBest() throws {
    let expected = kCLLocationAccuracyBest

    sut.setupLocationManager()
    let result = sut.locationManager.desiredAccuracy

    XCTAssertEqual(expected, result)
  }

  func testMapViewModel_allowsBackgroundLocationUpdates_returnFalse() throws {
    let expected = true
    let result = sut.locationManager.allowsBackgroundLocationUpdates

    XCTAssertEqual(expected, result)
  }

  func testMapViewModel_aroundUserDistance_returnFiftyThousand() throws {
    let expected: CLLocationDistance = 500000

    XCTAssertEqual(expected, sut.aroundUserDistance)
  }

  func testMapViewModel_airportsDataArrayEmptyAtInitialization_ReturnEmptyAirportDataArray() throws {
    let expected = [AirportData]()

    XCTAssertEqual(expected, sut.airports)
  }

  func testMapViewModel_getAllAirportsFromAPI_returnsFailure() throws {
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

  func testMapViewModel_getAllAirportsFromAPI_returnsSuccess() throws {
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

  func testMapViewModel_setupMapViewDelegate_returnNotNit() throws {
    sut.setupMapView()

    XCTAssertNotNil(sut.mapView.delegate)
  }
  
  func testMapViewModel_checkMapShowUserLocation_returnTrue() throws {
    let expected = true

    XCTAssertEqual(expected, sut.mapView.showsUserLocation)
  }

  func testMapViewModel_identifierValue_equalToAirportAnnotation() throws {
    let expected = "AirportAnnotation"

    XCTAssertEqual(expected, sut.identifier)
  }

  func testMapViewModel_aiportDetailsDictStartEmpty_returnEmptyDictionary() {
    let expected = [String: AirportDetailsData]()

    XCTAssertEqual(expected, sut.aiportDetailsDict)
  }

  func testMapViewModel_airportDetailskeyValue_returnDetails() {
    let expected = "details"

    XCTAssertEqual(expected, MapViewModel.airportDetailskey)
  }

  func testMapViewModel_foundAirportFurthestApart_returnAucklandAndMalaga() throws {
    sut.airports = loadFakeJsonAirports()
    let expected = [sut.airports[6], sut.airports[5]]

    sut.foundAirportsFurthestApart()

    XCTAssertEqual(expected, sut.furthestAirports)
  }
}
