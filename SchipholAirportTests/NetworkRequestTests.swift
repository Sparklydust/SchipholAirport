//
//  NetworkRequestTests.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 30/10/2020.
//

import XCTest
@testable import SchipholAirport

class NetworkRequestTests: XCTestCase {

  var airport: AirportData!
  var flight: FlightData!
  var airline: AirlineData!

  override func setUpWithError() throws {
    try super.setUpWithError()
    airport = AirportData(
      id: "AAL",
      latitude: 57.08655,
      longitude: 9.872241,
      name: "Aalborg Airport",
      city: "Aalborg",
      countryId: "DK")

    flight = FlightData(
      airlineId: "3O",
      flightNumber: 2128,
      departureAirportId: "AMS",
      arrivalAirportId: "TNG")

    airline = AirlineData(
      id: "5D",
      name: "AeroMexico Connect")

  }

  override func tearDownWithError() throws {
    airline = nil
    flight = nil
    airport = nil
    try super.tearDownWithError()
  }
}

// MARK: - Tests
extension NetworkRequestTests {
  func testNetworkRequest_getAllAirports_returnsAllAirportsFromAPI() throws {
    let expected = airport.name
    let mockURLSession = mockURLSessionResponseOK(data: FakeDataResponse.airportsCorrectData)

    let networkRequest = NetworkRequest<AirportData>(.airports,
                                                     resourceSession: mockURLSession)

    let expectation = XCTestExpectation(description: "all airports from api")

    networkRequest.getArray { response in
      switch response {
      case .failure:
        XCTAssert(false, "success should not retun a failure")
      case .success(let airports):
        XCTAssertNotNil(airports)
        XCTAssertEqual(expected, airports[0].name)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.1)
  }

  func testNetworkRequest_getAllAirports_returnsFailureForIncorrectResponse() throws {
    let mockURLSession = MockURLSession(data: FakeDataResponse.airportsCorrectData,
                                        response: FakeDataResponse.responseKO,
                                        error: nil)

    let networkRequest = NetworkRequest<AirportData>(.airports,
                                                     resourceSession: mockURLSession)

    let expectation = XCTestExpectation(description: "failure with incorrect response")

    networkRequest.getArray { response in
      switch response {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success(let airports):
        XCTAssertNil(airports)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.1)
  }
}

// MARK: - Flights API Tests
extension NetworkRequestTests {
  func testNetworkRequest_getAllFlights_returnsAllFlightsFromAPI() throws {
    let expected = flight.flightNumber
    let mockURLSession = mockURLSessionResponseOK(data: FakeDataResponse.flightsCorrectData)

    let networkRequest = NetworkRequest<FlightData>(.flights,
                                                    resourceSession: mockURLSession)

    let expectation = XCTestExpectation(description: "all flights from api")

    networkRequest.getArray { response in
      switch response {
      case .failure:
        XCTAssert(false, "success should not retun a failure")
      case .success(let flights):
        XCTAssertNotNil(flights)
        XCTAssertEqual(expected, flights[0].flightNumber)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.1)
  }

  func testNetworkRequest_getAllFlights_returnsFailureWithError() throws {
    let mockURLSession = MockURLSession(data: nil,
                                        response: nil,
                                        error: FakeDataResponse.error)

    let networkRequest = NetworkRequest<FlightData>(.flights,
                                                    resourceSession: mockURLSession)

    let expectation = XCTestExpectation(description: "failure with error")

    networkRequest.getArray { response in
      switch response {
      case .failure:
        XCTAssert(true, "success should retun a failure with an error")
      case .success(let flights):
        XCTAssertNil(flights)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.1)
  }
}

// MARK: - Airlines API Tests
extension NetworkRequestTests {
  func testNetworkRequest_getAllAirlines_returnsAllAirlinesFromAPI() throws {
    let expected = airline.name
    let mockURLSession = mockURLSessionResponseOK(data: FakeDataResponse.airlinesCorrectData)

    let networkRequest = NetworkRequest<AirlineData>(.airlines,
                                                     resourceSession: mockURLSession)

    let expectation = XCTestExpectation(description: "all airlines from api")

    networkRequest.getArray { response in
      switch response {
      case .failure:
        XCTAssert(false, "success should not retun a failure")
      case .success(let airlines):
        XCTAssertNotNil(airlines)
        XCTAssertEqual(expected, airlines[1].name)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.1)
  }

  func testNetworkRequest_getAllAirlinesIncorrectData_returnsFailureFromAPI() throws {
    let mockURLSession = MockURLSession(data: FakeDataResponse.incorrectData,
                                        response: FakeDataResponse.response200OK,
                                        error: nil)

    let networkRequest = NetworkRequest<AirlineData>(.airlines,
                                                     resourceSession: mockURLSession)

    let expectation = XCTestExpectation(description: "failure with incorrect data")

    networkRequest.getArray { response in
      switch response {
      case .failure:
        XCTAssert(true, "success should retun a failure")
      case .success(let airlines):
        XCTAssertNil(airlines)
      }
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 0.1)
  }
}

// MARK: - Helpers
extension NetworkRequestTests {
  /// Helper to mock url session with api response 200.
  ///
  func mockURLSessionResponseOK(data: Data) -> MockURLSession {
    MockURLSession(data: data,
                   response: FakeDataResponse.response200OK,
                   error: nil)
  }
}
