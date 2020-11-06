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

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = AirportDetailsVC()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
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

  func testAirportDetailsVC_detailsNotification_returnAirportDetailsVC() throws {
    let expected = "AirportDetailsVC"

    XCTAssertEqual(expected, AirportDetailsVC.detailsNotification)
  }

  func testAirportDetailsVC_backgroundViewColor_returnCustomColorBackground$() throws {
    let expected: UIColor = .background$ ?? UIColor()

    XCTAssertEqual(expected, sut.view.backgroundColor)
  }
}
