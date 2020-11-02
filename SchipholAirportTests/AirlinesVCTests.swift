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

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = AirlinesVC()

    sut.airlinesDownloader.resourceSession =
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
    let expected = sut.airlines.count

    sut.loadViewIfNeeded()
    let result = sut.tableView(sut.tableView, numberOfRowsInSection: 0)

    XCTAssertEqual(expected, result)
  }

  func testAirlinesVC_checkTableViewCell_returnsAirlineTVCCell() throws {
    let expected = "AeroMexico Connect"
    sut.airlines = loadFakeJsonAirlines()

    let cell = sut.tableView(
      sut.tableView,
      cellForRowAt: IndexPath(row: 1, section: 0)) as? AirlineTVC

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

    wait(for: [expectation], timeout: 0.1)
    XCTAssertEqual(expected, sut.airlines.count)
  }

  func testAirlinesVC_getAllAirlinesFromAPI_returnAirlinesWithSuccess() throws {
    let expected = 3

    let expectation = XCTestExpectation(description: "Success with airlines from api in an array")

    sut.airlinesDownloader.resourceSession =
      MockURLSession(
        data: FakeDataResponse.airlinesCorrectData,
        response: FakeDataResponse.response200OK,
        error: nil)

    sut.downloadAirlines { expectation.fulfill() }

    wait(for: [expectation], timeout: 0.1)
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
}
