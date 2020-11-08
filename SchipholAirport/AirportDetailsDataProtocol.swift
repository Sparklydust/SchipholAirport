//
//  AirportDetailsDataProtocol.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 05/11/2020.
//

import Foundation

//  MARK: - AirportDetailsDataProtocol
/// Model protocol of data being populated on
/// AirportDetailsVC send from MapViewModel.
///
protocol AirportDetailsDataProtocol {

  var airportData: AirportData { get set }
  var nearestAirport: String { get set }
  var airportsDistance: Double { get set }
}
