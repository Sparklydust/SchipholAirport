//
//  UIColor+NameTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 29/10/2020.
//

import XCTest
@testable import SchipholAirport

class UIColor_NameTests: XCTestCase {

  func testUIColorName_background$() throws {
    let expected = UIColor(named: "background$")

    XCTAssertEqual(expected, UIColor.background$)
  }

  func testUIColorName_accentColor$() throws {
    let expected = UIColor(named: "accentColor$")

    XCTAssertEqual(expected, UIColor.accentColor$)
  }
}
