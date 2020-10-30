//
//  FlightsData.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 30/10/2020.
//

import Foundation

//  MARK: FlightsData
/// Flights data coming from the api.
///
struct FlightsData: FlightsProtocol, Codable, Equatable {

  var airlineId: String
  var flightNumber: Int
  var departureAirportId: String
  var arrivalAirportId: String
}
