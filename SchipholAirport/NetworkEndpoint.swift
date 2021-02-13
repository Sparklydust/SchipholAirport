//
//  NetworkEndpoint.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 30/10/2020.
//

import Foundation

//  MARK: NetworkEndpoint
/// SchipholAirport network url endpoints enumeration.
///
/// All urls are handled by this enum with a base url
/// and endpoints for each network call.
///
/// ```
/// NetworkEndpoint.airports.url  // example of use
/// ```
enum NetworkEndpoint {

  /// Base api url.
  ///
  static let baseURL = URL(string: "https://flightassets.datasavannah.com/test/")!

  // API endpoints
  case airports
  case flights
  case airlines

  /// Fetching SchipholAirport endpoint.
  ///
  var url: URL {
    switch self {
    case .airports:
      return NetworkEndpoint.baseURL.appendingPathComponent("airports.json")
    case .flights:
      return NetworkEndpoint.baseURL.appendingPathComponent("flights.json")
    case .airlines:
      return NetworkEndpoint.baseURL.appendingPathComponent("airlines.json")
    }
  }
}
