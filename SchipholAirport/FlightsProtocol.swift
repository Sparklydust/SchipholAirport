//
//  FlightsProtocol.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 30/10/2020.
//

import Foundation

//  MARK: FlightsProtocol
/// Model protocol of flights data.
///
protocol FlightsProtocol {
  
  var airlineId: String { get set }
  var flightNumber: Int { get set }
  var departureAirportId: String { get set }
  var arrivalAirportId: String { get set }
}
