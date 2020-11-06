//
//  AirportDetailsData.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 05/11/2020.
//

import Foundation

//  MARK: AirportDetailsData
/// Data to be retrieve in AirportDetailsVC.
///
struct AirportDetailsData: AirportDetailsDataProtocol, Equatable {

  var airportData: AirportData
  var nearestAirport: String
  var airportsDistance: Double
}
