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

  func testFlightsVC_viewTitle_LocalizedFlights() throws {
    let expected = Localized.flights

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.title)
  }

  func testFlightsVC_flightsVariableOfFlightsData_mustBeAnEmptyArrayAtStart() throws {
    let expected = [FlightsData]()

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
    let expected: String? = nil

    let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? FlightsTVC

    XCTAssertEqual(expected, cell?.flightsLabel.text)
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
    let expected = 3

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
}
