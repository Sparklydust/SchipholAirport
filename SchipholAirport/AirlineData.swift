//
//  AirlineData.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 30/10/2020.
//

import Foundation

//  MARK: AirlineData
/// Airlines data coming from the api.
///
struct AirlineData: AirlinesProtocol, Codable, Equatable, Hashable {

  var id: String
  var name: String
}
