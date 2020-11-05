//
//  AirportDetailsData.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 05/11/2020.
//

import Foundation

struct AirportDetailsData: AirportDetailsDataProtocol {

  var airportData: AirportData
  var nearestAirport: String
  var airportsDistance: Double
}
