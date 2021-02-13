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

  var airline30: AirlineData!
  var airlineAF: AirlineData!

  var fakeUserDefaultsService: UserDefaultsService!
  var mockUserDefaultsContainer: MockUserDefaultsContainer!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = AirlinesVC()

    airline30 = AirlineData(
      id: "3O",
      name: "Air Arabia Maroc")
    airlineAF = AirlineData(
      id: "AF",
      name: "Air France")

    sut.airlinesDownloader.resourceSession =
      MockURLSession(data: nil,
                     response: nil,
                     error: nil)

    mockUserDefaultsContainer = MockUserDefaultsContainer()
    fakeUserDefaultsService = UserDefaultsService(userDefaultsContainer: mockUserDefaultsContainer)
  }

  override func tearDownWithError() throws {
    fakeUserDefaultsService = nil
    mockUserDefaultsContainer = nil
    airlineAF = nil
    airline30 = nil
    sut = nil
    try super.tearDownWithError()
  }
}

// MARK: - Helpers
extension AirlinesVCTests {
  /// Load fake airlines data from json file inside Fakes/Json folder.
  ///
  func loadFakeJsonAirlines() -> [AirlineData] {
    let bundle = Bundle(for: AirlinesVCTests.self)
    let url = bundle.url(forResource: "Airlines", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    let airlines = try! JSONDecoder().decode([AirlineData].self, from: data)
    return airlines
  }

  /// Load fake flights data from json file inside Fakes/Json folder.
  ///
  func loadFakeJsonFlights() -> [FlightData] {
    let bundle = Bundle(for: AirlinesVCTests.self)
    let url = bundle.url(forResource: "Flights", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    let flights = try! JSONDecoder().decode([FlightData].self, from: data)
    return flights
  }

  /// Load fake airports data from json file inside Fakes/Json folder.
  ///
  func loadFakeJsonAirports() -> [AirportData] {
    let bundle = Bundle(for: AirlinesVCTests.self)
    let url = bundle.url(forResource: "Airports", withExtension: "json")
    let data = try! Data(contentsOf: url!)

    let airports = try! JSONDecoder().decode([AirportData].self, from: data)
    return airports
  }

  /// Loading sorted Airlines in sut.airlinesSorted to
  /// test code behavior with data.
  ///
  func loadFakeAirlinesSortedDataForTest() {
    sut.flights = loadFakeJsonFlights()
    sut.airlines = loadFakeJsonAirlines()
    sut.airports = loadFakeJsonAirports()
    sut.populateAirlines()
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
    let expected = sut.airlinesSorted.count

    sut.loadViewIfNeeded()
    let result = sut.tableView(sut.tableView, numberOfRowsInSection: 0)

    XCTAssertEqual(expected, result)
  }

  func testAirlinesVC_checkTableViewCell_returnsAirlineTVCCell() throws {
    let expected = "Air France"
    loadFakeAirlinesSortedDataForTest()

    let cell = sut.tableView(
      sut.tableView,
      cellForRowAt: IndexPath(row: 0, section: 0)) as? AirlineTVC

    XCTAssertEqual(expected, cell?.nameLabel.text)
  }

  func testAirlinesVC_getAllAirlinesFromAPI_returnsZeroAirlinesWithFailure() throws {
    let expected = 0

    let expectation = XCTestExpectation(description: "Failure from api call")

    sut.airlinesDownloader.resourceSession =
      MockURLSession(
        data: FakeDataResponse.airlinesCorrectData,
        response: FakeDataResponse.responseKO,
        error: nil)

    sut.downloadAirlines { expectation.fulfill() }

    wait(for: [expectation], timeout: 1)
    XCTAssertEqual(expected, sut.airlines.count)
  }

  func testAirlinesVC_getAllAirlinesFromAPI_returnAirlinesWithSuccess() throws {
    let expected = 4

    let expectation = XCTestExpectation(description: "Success with airlines from api in an array")

    sut.airlinesDownloader.resourceSession =
      MockURLSession(
        data: FakeDataResponse.airlinesCorrectData,
        response: FakeDataResponse.response200OK,
        error: nil)

    sut.downloadAirlines { expectation.fulfill() }

    wait(for: [expectation], timeout: 1)
    XCTAssertEqual(expected, sut.airlines.count)
  }

  func testAirlinesVC_showAlert_returnLocalizedFailureMessageInPopUp() throws {
    let expected = Localized.downloadFailureMessage

    sut.showDownloadFailureAlert()

    XCTAssertEqual(expected, sut.alert.message)
  }

  func testAirlinesVC_showReloadButton_buttonIsPopulated() throws {
    sut.populateTryAgainButton()

    XCTAssertTrue(sut.tryAgainButton.isEnabled)
  }

  func testAirlinesVC_reloadButtonIsTapped_flightsDataIsBeignReloaded() throws {
    let expected = 0

    sut.tryAgainButtonAction()

    XCTAssertEqual(expected, sut.airlines.count)
  }

  func testAirlinesVC_getAllFlightsFromAPI_returnsZeroFlightsWithFailure() throws {
    let expected = 0

    let expectation = XCTestExpectation(
      description: "Failure from api call")

    sut.flightsDownloader.resourceSession =
      MockURLSession(
        data: FakeDataResponse.flightsCorrectData,
        response: FakeDataResponse.responseKO,
        error: nil)

    sut.downloadFlights { expectation.fulfill() }

    wait(for: [expectation], timeout: 1)
    XCTAssertEqual(expected, sut.flights.count)
  }

  func testAirlinesVC_getAllFlightsFromAPI_returnsFlightsWithSuccess() throws {
    let expected = 3

    let expectation = XCTestExpectation(
      description: "Success with flights from api in an array")

    sut.flightsDownloader.resourceSession =
      MockURLSession(
        data: FakeDataResponse.flightsCorrectData,
        response: FakeDataResponse.response200OK,
        error: nil)

    sut.downloadFlights { expectation.fulfill() }

    wait(for: [expectation], timeout: 1)
    XCTAssertEqual(expected, sut.flights.count)
  }

  func testAirlinesVC_getAllAirportsFromAPI_returnsAirportsWithSuccess() throws {
    let expected = 0

    let expectation = XCTestExpectation(
      description: "Success with airports from api in an array")

    sut.airportsDownloader.resourceSession =
      MockURLSession(
        data: FakeDataResponse.airportsCorrectData,
        response: FakeDataResponse.response200OK,
        error: nil)

    sut.downloadData { expectation.fulfill() }

    wait(for: [expectation], timeout: 1)
    XCTAssertEqual(expected, sut.airports.count)
  }

  func testAirlinesVC_getAllAirportsFromAPI_returnsFailureWithAlert() throws {
    let expected = 0

    let expectation = XCTestExpectation(
      description: "Success with airports from api in an array")

    sut.airportsDownloader.resourceSession =
      MockURLSession(
        data: nil,
        response: nil,
        error: FakeDataResponse.error)

    sut.downloadAirports { expectation.fulfill() }

    wait(for: [expectation], timeout: 1)
    XCTAssertEqual(expected, sut.airports.count)
  }

  func testAirlinesVC_distanceFormat_returnsValidFormatWithDistanceAndUnit() {
    let expected = "%.2f %@"

    XCTAssertEqual(expected, sut.distanceFormat)
  }

  func testAirlinesVC_schipholAirportID_returnAMS() throws {
    let expected = "AMS"

    XCTAssertEqual(expected, sut.schipholAirportID)
  }

  func testAirlinesVC_schipholAirportLocation_returnsCorrectLatitudeLongitude() throws {
    let expectedLatitude = 52.30907
    let expectedLongitude = 4.763385

    XCTAssertEqual(expectedLatitude, sut.schipholLocation.coordinate.latitude)
    XCTAssertEqual(expectedLongitude, sut.schipholLocation.coordinate.longitude)
  }

  func testAirlinesVC_checkDistanceUnitSettings_changeUnitIfNewValueFromSettings() throws {
    sut.isInKm = fakeUserDefaultsService.isInKm
    sut.trackIsInKm = !fakeUserDefaultsService.isInKm

    sut.checkDistanceUnitSettings()

    XCTAssertEqual(!sut.isInKm, sut.trackIsInKm)
  }

  func testAirlinesVC_checkTrackIsInKmHasSameValueAsIsInKm_changeTrackIsInKmOppositeBoolToIsInKm() throws {
    sut.isInKm = fakeUserDefaultsService.isInKm
    sut.trackIsInKm = fakeUserDefaultsService.isInKm

    sut.viewWillAppear(false)

    XCTAssertEqual(!sut.isInKm, sut.trackIsInKm)
  }

  func testAirlinesVC_filterFlightsData_returnsFlightsConnectedToSchiphol() throws {
    let expected = 3
    sut.flights = loadFakeJsonFlights()

    sut.filterFlightsFromSchiphol()

    XCTAssertEqual(expected, sut.flightsConnected.count)
  }

  func testAirlinesVC_filterAirlinesDeparture_returnAirlinesConnectedToSchiphol() throws {
    let expected = 2
    sut.flightsConnected = loadFakeJsonFlights()
    sut.airlines = loadFakeJsonAirlines()

    sut.filterAirlinesFromSchiphol()

    XCTAssertEqual(expected, sut.airlinesConnected.count)
  }

  func testAirlinesVC_setAirlinesIntoADictionaryWithZeroAsValue_returnAirlinesDictionary() throws {
    let expected: [AirlineData: Double] = [
      airlineAF: 0,
      airline30: 0
    ]
    sut.isInKm = false
    sut.flightsConnected = loadFakeJsonFlights()
    sut.airlinesConnected = loadFakeJsonAirlines()
    sut.airports = loadFakeJsonAirports()

    sut.setAirlinesConnectedDictionary()

    XCTAssertEqual(expected, sut.airlinesDictionary)
  }

  func testAirlinesVC_calculateAirlineDistanceFromSchiphol_returnAirlinesDictWithTotalDistanceOfAllFlightInKm() throws {
    let expected: [AirlineData: Double] = [
      airlineAF: 798.3115413997741,
      airline30: 2026.634960748272
    ]
    sut.isInKm = true

    loadFakeAirlinesSortedDataForTest()

    XCTAssertEqual(expected, sut.airlinesDictionary)
  }

  func testAirlinesVC_calculateAirlineDistanceFromSchiphol_returnAirlinesDictWithTotalDistanceOfAllFlightInMiles() throws {
    let expected: [AirlineData: Double] = [
      airlineAF: 496.0476407911191,
      airline30: 1259.2921921951145
    ]
    sut.isInKm = false
    
    loadFakeAirlinesSortedDataForTest()

    XCTAssertEqual(expected, sut.airlinesDictionary)
  }

  func testAirlinesVC_reinitAirlinesDictionaryAtViewDidLoad_returnEmptyValues() throws {
    let expected = [AirlineData: Double]()
    loadFakeAirlinesSortedDataForTest()

    sut.reinitAirlinesFlightsValues()

    XCTAssertEqual(expected, sut.airlinesDictionary)
  }

  func testAirlinesVC_reinitFlightsConnectedAtViewDidLoad_returnEmptyValues() throws {
    let expected = [FlightData]()
    loadFakeAirlinesSortedDataForTest()

    sut.reinitAirlinesFlightsValues()

    XCTAssertEqual(expected, sut.flightsConnected)
  }
}
