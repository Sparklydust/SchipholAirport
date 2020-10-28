//
//  MainVCTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 28/10/2020.
//

import XCTest
@testable import SchipholAirport

class MainVCTests: XCTestCase {

  var sut: MainVC!

  override func setUpWithError() throws {
    try super.setUpWithError()
    sut = MainVC()
  }

  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
}
