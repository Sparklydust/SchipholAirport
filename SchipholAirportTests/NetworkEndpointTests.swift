//
//  NetworkEndpointTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 02/11/2020.
//

import XCTest
@testable import SchipholAirport

class NetworkEndpointTests: XCTestCase {

  func testNetworkEndpoint_apiAirportsEndpoint_returnCorrectURL() throws {
    let expected = URL(string: "https://flightassets.datasavannah.com/test/airports.json")!

    XCTAssertEqual(expected, NetworkEndpoint.airports.url)
  }

  func testNetworkEndpoint_apiFlightsEndpoint_returnCorrectURL() throws {
    let expected = URL(string: "https://flightassets.datasavannah.com/test/flights.json")!

    XCTAssertEqual(expected, NetworkEndpoint.flights.url)
  }

  func testNetworkEndpoint_apiAirlinesEndpoint_returnCorrectURL() throws {
    let expected = URL(string: "https://flightassets.datasavannah.com/test/airlines.json")!

    XCTAssertEqual(expected, NetworkEndpoint.airlines.url)
  }
}
