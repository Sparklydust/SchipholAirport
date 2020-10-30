//
//  FakeDataResponse.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 30/10/2020.
//

import Foundation

//  MARK: FakeDataResponse
/// Create fake data responses for testing purposes.
///
final class FakeDataResponse {

  static let response200OK = HTTPURLResponse(url: URL(string: "https://www.fake.com")!,
                                   statusCode: 200, httpVersion: nil, headerFields: nil)!
  static let responseKO = HTTPURLResponse(url: URL(string: "https://www.fake.com")!,
                                   statusCode: 500, httpVersion: nil, headerFields: nil)!

  /// Fake error response from api
  ///
  class ResourceError: Error {}
  static let error = ResourceError()

  /// Bundle from Fakes/Json to get the hard coded airports data.
  ///
  static var airportsCorrectData: Data {
    let bundle = Bundle(for: FakeDataResponse.self)
    let url = bundle.url(forResource: "Airports", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    return data
  }

  /// Bundle from Fakes/Json to get the hard coded flights data.
  ///
  static var flightsCorrectData: Data {
    let bundle = Bundle(for: FakeDataResponse.self)
    let url = bundle.url(forResource: "Flights", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    return data
  }

  /// Bundle from Fakes/Json to get the hard coded airlines data.
  ///
  static var airlinesCorrectData: Data {
    let bundle = Bundle(for: FakeDataResponse.self)
    let url = bundle.url(forResource: "Airlines", withExtension: "json")
    let data = try! Data(contentsOf: url!)
    return data
  }

  /// Setting the wrong data back from fake api call.
  static let incorrectData = "error".data(using: .utf8)!
}
