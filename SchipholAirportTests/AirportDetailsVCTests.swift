//
//  AirportDetailsVCTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 05/11/2020.
//

import XCTest
@testable import SchipholAirport

class AirportDetailsVCTests: XCTestCase {

  var sut: AirportDetailsVC!

  var fakeUserDefaultsService: UserDefaultsService!
  var mockUserDefaultsContainer: MockUserDefaultsContainer!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = AirportDetailsVC()

    mockUserDefaultsContainer = MockUserDefaultsContainer()
    fakeUserDefaultsService = UserDefaultsService(userDefaultsContainer: mockUserDefaultsContainer)
  }

  override func tearDownWithError() throws {
    fakeUserDefaultsService = nil
    mockUserDefaultsContainer = nil
    sut = nil
    try super.tearDownWithError()
  }
}

// MARK: - Helpers
extension AirportDetailsVCTests {
  /// Load fake airports data from json file inside Fakes/Json folder.
  ///
  func loadFakeJsonAirports() -> [AirportData] {
    let bundle = Bundle(for: AirportDetailsVCTests.self)
    let url = bundle.url(forResource: "Airports", withExtension: "json")
    let data = try! Data(contentsOf: url!)

    let airports = try! JSONDecoder().decode([AirportData].self, from: data)
    return airports
  }
}

// MARK: - Tests
extension AirportDetailsVCTests {
  func testAirportDetailsVC_viewTitle_LocalizedDetails() throws {
    let expected = Localized.details

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.title)
  }

  func testAirportDetailsVC_idLabelText_LocalzedIdLabel() throws {
    let expected = Localized.idLabel

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.idLabel.text)
  }

  func testAirportDetailsVC_latLabelText_LocalizedLatLabel() throws {
    let expected = Localized.latLabel

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.latLabel.text)
  }

  func testAirportDetailsVC_latLabelText_LocalizedLongLabel() throws {
    let expected = Localized.longLabel

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.longLabel.text)
  }

  func testAirportDetailsVC_nameLabelText_LoalizedNameLabel() throws {
    let expected = Localized.nameLabel

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.nameLabel.text)
  }

  func testAirportDetailsVC_cityLabelText_LocalizedCityLabel() throws {
    let expected = Localized.cityLabel

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.cityLabel.text)
  }

  func testAirportDetailsVC_countryIdLabelText_LocalizedCountryId() throws {
    let expected = Localized.countryIdLabel

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.countryIdLabel.text)
  }

  func testAirportDetailsVC_nearestAirportLabelText_LocalizedNearestAirportLabel() throws {
    let expected = Localized.nearestAirportLabel

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.nearestAirportLabel.text)
  }

  func testAirportDetailsVC_distanceAirportsLabelText_LocalizedDistanceAirportsLabel() throws {
    let expected = Localized.distanceAirportsLabel

    sut.loadViewIfNeeded()

    XCTAssertEqual(expected, sut.distanceAirportsLabel.text)
  }

  func testAirportDetailsVC_backgroundViewColor_returnCustomColorBackground$() throws {
    let expected: UIColor = .background$ ?? UIColor()

    XCTAssertEqual(expected, sut.view.backgroundColor)
  }

  func testAiportDetailsVC_setupDataLabelUnitSetWithUserDefaults_returnDistanceInkm() throws {
    let expected = "234.34 km"
    mockUserDefaultsContainer.isInKm = true
    sut.isInKm = mockUserDefaultsContainer.isInKm
    sut.distanceAirports = 234.34

    sut.setupDataInLabels()

    XCTAssertEqual(expected, sut.distanceAirportsDataLabel.text)
  }

  func testAiportDetailsVC_setupDataLabelUnitSetWithUserDefaults_returnDistanceInMiles() throws {
    let expected = "567.32 mi"
    mockUserDefaultsContainer.isInKm = false
    sut.isInKm = mockUserDefaultsContainer.isInKm
    sut.distanceAirports = 567.32

    sut.setupDataInLabels()

    XCTAssertEqual(expected, sut.distanceAirportsDataLabel.text)
  }

  func testAirportDetailsVC_viewWillAppearChangeCityDataLabel_returnAirportCityValueInLabel() throws {
    let expected = "Aberdeen"
    let airports = loadFakeJsonAirports()
    sut.city = airports[2].city

    sut.viewWillAppear(true)

    XCTAssertEqual(expected, sut.cityDataLabel.text)
  }
}
