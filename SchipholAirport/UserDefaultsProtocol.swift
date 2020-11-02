//
//  UserDefaultsProtocol.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 02/11/2020.
//

import Foundation

//  MARK: UserDefaultsProtocol
///
protocol UserDefaultsProtocol {

  /// Track user settings for distance unit.
  ///
  var isInKm: Bool { get set }
}
