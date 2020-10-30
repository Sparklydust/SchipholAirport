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
  var latitude: Int { get set }
  var longitude: Int { get set }
  var name: String { get set }
  var city: String { get set }
  var countryId: String { get set }
}
