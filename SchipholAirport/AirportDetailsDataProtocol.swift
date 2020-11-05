//
//  AirportDetailsDataProtocol.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 05/11/2020.
//

import Foundation

protocol AirportDetailsDataProtocol {

  var airportData: AirportData { get set }
  var nearestAirport: String { get set }
  var airportsDistance: Double { get set }
}
