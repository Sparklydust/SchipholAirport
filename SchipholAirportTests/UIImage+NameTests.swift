//
//  UIImage+NameTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 29/10/2020.
//

import XCTest
@testable import SchipholAirport

class UIImage_NameTests: XCTestCase {

  func testUIImageName_airportsIcon() throws {
    let expected = UIImage(named: "airportsIcon")

    XCTAssertEqual(expected, UIImage.airportsIcon)
  }

  func testUIImageName_flightsIcon() throws {
    let expected = UIImage(named: "flightsIcon")

    XCTAssertEqual(expected, UIImage.flightsIcon)
  }

  func testUIImageName_airlinesIcon() throws {
    let expected = UIImage(named: "airlinesIcon")

    XCTAssertEqual(expected, UIImage.airlinesIcon)
  }

  func testUIImageName_settingsIcon() throws {
    let expected = UIImage(named: "settingsIcon")

    XCTAssertEqual(expected, UIImage.settingsIcon)
  }

  func testUIImageName_flightAnnotation() throws {
    let expected = UIImage(named: "flightAnnotation")

    XCTAssertEqual(expected, UIImage.flightAnnotation)
  }

  func testUIImageName_goldFlightAnnotation() throws {
    let expected = UIImage(named: "goldFlightAnnotation")

    XCTAssertEqual(expected, UIImage.goldFlightAnnotation)
  }
}
