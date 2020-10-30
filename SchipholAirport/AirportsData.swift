//
//  AirportsData.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 30/10/2020.
//

import Foundation

//  MARK: AirportsData
/// Airports data coming from the api.
///
struct AirportsData: AirportsProtocol, Codable {

  var id: String
  var latitude: Double
  var longitude: Double
  var name: String
  var city: String
  var countryId: String
}
