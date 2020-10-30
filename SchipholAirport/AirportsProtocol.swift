//
//  AirportsProtocol.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 30/10/2020.
//

import Foundation

//  MARK: AirportsProtocol
/// Model protocol of airports data.
///
protocol AirportsProtocol {
  
  var id: String { get set }
  var latitude: Double { get set }
  var longitude: Double { get set }
  var name: String { get set }
  var city: String { get set }
  var countryId: String { get set }
}
