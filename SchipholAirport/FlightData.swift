//
//  FlightData.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 30/10/2020.
//

import Foundation

//  MARK: FlightData
/// Flights data coming from the api.
///
struct FlightData: FlightsProtocol, Codable, Equatable {

  var airlineId: String
  var flightNumber: Int
  var departureAirportId: String
  var arrivalAirportId: String
}
