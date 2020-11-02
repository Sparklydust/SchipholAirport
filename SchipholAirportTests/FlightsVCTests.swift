//
//  FlightsVCTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 28/10/2020.
//

import XCTest
@testable import SchipholAirport

class FlightsVCTests: XCTestCase {

  var sut: FlightsVC!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = FlightsVC()

    sut.flightsDownloader.resourceSession =
      MockURLSession(data: nil,
                     response: nil,
                     error: nil)
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
}

// MARK: - Helpers
extension FlightsVCTests {
  /// Load fake flights data from json file inside Fakes/Json folder.
  ///
  func loadFakeJsonFlights() -> [FlightData] {
    let bundle = Bundle(for: FlightsVCTests.self)
    let url = bundle.url(forResource: "Flights", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    let flights = try! JSONDecoder().decode([FlightData].self, from: data)
    return flights
  }

  /// Load fake airports data from json file inside Fakes/Json folder.
  ///
  func loadFakeJsonAirports() -> [AirportData] {
    let bundle = Bundle(for: FlightsVCTests.self)
    let url = bundle.url(forResource: "Airports", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    let airports = try! JSONDecoder().decode([AirportData].self, from: data)
    return airports
  }
}

// MARK: - Tests
extension FlightsVCTests {
  func testFlightsVC_viewTitle_LocalizedFlights() throws {
    let expected = Localized.flights

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.title)
  }

  func testFlightsVC_flightsVariableOfFlightsData_mustBeAnEmptyArrayAtStart() throws {
    let expected = [FlightData]()

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.flights)
  }

  func testFlightsVC_checkIfTableViewExists_returnNotNil() throws {
    sut.loadViewIfNeeded()

    XCTAssertNotNil(sut.tableView)
  }

  func testFlightsVC_TableViewHasDelegate_returnNotNil() {
      XCTAssertNotNil(sut.tableView.delegate)
  }

  func testFlightsVC_checkTableViewNumberOfRows_returnFlightsArrayCount() throws {
    let expected = sut.flights.count

    sut.loadViewIfNeeded()
    let rowCount = sut.tableView(sut.tableView, numberOfRowsInSection: 0)

    XCTAssertEqual(expected, rowCount)
  }

  func testFlightVC_checkTableViewCell_returnsFlightsTVCCell() throws {
    let expected = "Aalborg Airport"
    sut.airportsConnected = loadFakeJsonAirports()

    let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? FlightsTVC

    XCTAssertEqual(expected, cell?.nameLabel.text)
  }

  func testFlightsTVC_getAllFlightsFromAPI_returnsZeroFlightsWithFailure() throws {
    let expected = 0

    let expectation = XCTestExpectation(
      description: "Failure from api call")

    sut.flightsDownloader.resourceSession =
      MockURLSession(
        data: FakeDataResponse.flightsCorrectData,
        response: FakeDataResponse.responseKO,
        error: nil)

    sut.downloadFlights { expectation.fulfill() }

    wait(for: [expectation], timeout: 0.1)
    XCTAssertEqual(expected, sut.flights.count)
  }

  func testFlightsTVC_getAllFlightsFromAPI_returnsFlightsWithSuccess() throws {
    let expected = 3

    let expectation = XCTestExpectation(
      description: "Success with flights from api in an array")

    sut.flightsDownloader.resourceSession =
      MockURLSession(
        data: FakeDataResponse.flightsCorrectData,
        response: FakeDataResponse.response200OK,
        error: nil)

    sut.downloadFlights { expectation.fulfill() }

    wait(for: [expectation], timeout: 0.1)
    XCTAssertEqual(expected, sut.flights.count)
  }

  func testFlightVC_showAlert_returnLocalizedFailureMessageInPopUp() throws {
    let expected = Localized.downloadFailureMessage

    sut.showDownloadFailureAlert()

    XCTAssertEqual(expected, sut.alert.message)
  }

  func testFlightVC_showRealodButton_buttonIsPopulated() throws {
    sut.populateReloadButton()

    XCTAssertTrue(sut.reloadButton.isEnabled)
  }

  func testFlightVC_reloadButtonIsTapped_flightsDataIsBeingRealoded() throws {
    let expected = 0

    sut.reloadButtonAction()

    XCTAssertEqual(expected, sut.flights.count)
  }

  func testFlightsTVC_getAllAirportsFromAPI_returnsAirportsWithSuccess() throws {
    let expected = 12

    let expectation = XCTestExpectation(
      description: "Success with airports from api in an array")

    sut.airportsDownloader.resourceSession =
      MockURLSession(
        data: FakeDataResponse.airportsCorrectData,
        response: FakeDataResponse.response200OK,
        error: nil)

    sut.downloadData { expectation.fulfill() }

    wait(for: [expectation], timeout: 0.1)
    XCTAssertEqual(expected, sut.airports.count)
  }

  func testFlightsTVC_getAllAirportsFromAPI_returnsFailureWithAlert() throws {
    let expected = 0

    let expectation = XCTestExpectation(
      description: "Success with airports from api in an array")

    sut.airportsDownloader.resourceSession =
      MockURLSession(
        data: nil,
        response: nil,
        error: FakeDataResponse.error)

    sut.downloadAirports { expectation.fulfill() }

    wait(for: [expectation], timeout: 0.1)
    XCTAssertEqual(expected, sut.airports.count)
  }

  func testFlightsVC_schipholAirportID_returnAMS() throws {
    let expected = "AMS"

    XCTAssertEqual(expected, sut.schipholAirportID)
  }

  func testFlightsVC_filterFlightsData_returnsFlightsConnectedToSchiphol() throws {
    let expected = 2
    sut.flights = loadFakeJsonFlights()

    sut.filterFlightsFromSchiphol()

    XCTAssertEqual(expected, sut.flightsConnected.count)
  }

  func testFlightsVC_filterAirportsData_returnsAirportsConnectedToSchiphol() throws {
    let expected = 1
    sut.flightsConnected = loadFakeJsonFlights()
    sut.airports = loadFakeJsonAirports()

    sut.filterAirportsConnectedToSchiphol()

    XCTAssertEqual(expected, sut.airportsConnected.count)
  }

  func testFlightsVC_populateFlightsAndAirportsData_returnAirportsConnectedToSchiphol() throws {
    let expected = 1
    sut.flights = loadFakeJsonFlights()
    sut.airports = loadFakeJsonAirports()

    sut.populateAirports()

    XCTAssertEqual(expected, sut.airportsConnected.count)
  }

  func testFlightsVC_schipholAirportLocation_returnsCorrectLatitudeLongitude() throws {
    let expectedLatitude = 52.30907
    let expectedLongitude = 4.763385

    XCTAssertEqual(expectedLatitude, sut.schipholLocation.coordinate.latitude)
    XCTAssertEqual(expectedLongitude, sut.schipholLocation.coordinate.longitude)
  }

  func testFlightsVC_sortConnectedAirportsInOrder_returnsAscendingOrder() throws {
    let expected = "Amsterdam-Schiphol Airport"
    sut.airportsConnected = loadFakeJsonAirports()

    sut.sortConnectedAirports()

    XCTAssertEqual(expected, sut.airportsConnected[0].name)
  }

  func testFlightVC_distanceFormat_returnsValidFormatWithDistanceAndUnit() {
    let expected = "%.2f %@"

    XCTAssertEqual(expected, sut.distanceFormat)
  }

  func testFlightsVC_kmDistanceValueFromAirports_returnsStringWithDistanceAndUnit() throws {
    let expected = "625.17 km"
    let airports = loadFakeJsonAirports()
    let airport = airports[0]

    let result = sut.distanceFromSchiphol(to: airport)

    XCTAssertEqual(expected, result)
  }

  func testFlightsVC_milesDistanceValueFromAirports_returnsStringWithDistanceAndUnit() throws {
    let expected = "388.46 mi"
    sut.isInKm = false
    let airports = loadFakeJsonAirports()
    let airport = airports[0]

    let result = sut.distanceFromSchiphol(to: airport)

    XCTAssertEqual(expected, result)
  }
}
