//
//  UserDefaultsProtocol.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 02/11/2020.
//

import Foundation

//  MARK: UserDefaultsProtocol
/// Rewrite value from User Defaults for
/// testing purposes.
///
protocol UserDefaultsProtocol {

  /// Track user settings for distance unit.
  ///
  var isInKm: Bool { get set }
}
