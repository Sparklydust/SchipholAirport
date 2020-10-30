//
//  AirlinesData.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 30/10/2020.
//

import Foundation

//  MARK: AirlinesData
/// Airlines data coming from the api.
///
struct AirlinesData: AirlinesProtocol, Codable {

  var id: String
  var name: String
}
