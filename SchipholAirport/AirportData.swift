//
//  AirportData.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 30/10/2020.
//

import Foundation
import CoreLocation

//  MARK: AirportData
/// Airports data coming from the api.
///
/// Additional elements from the api are added to
/// AirportData, the location and func distance(location:).
///
struct AirportData: AirportsProtocol, Codable, Equatable, Hashable {

  var id: String
  var latitude: Double
  var longitude: Double
  var name: String
  var city: String
  var countryId: String

  /// Setup airport location.
  ///
  var location: CLLocation {
    return CLLocation(latitude: latitude,
                      longitude: longitude)
  }

  /// Calculate distance from two core location points in km
  /// or in miles.
  ///
  /// Used to calculate the distance between two airports.
  ///
  func distance(_ isInKm: Bool = true, to location: CLLocation) -> CLLocationDistance {
    guard isInKm else {
      return self.location.distance(from: location) * 0.000621371
    }
    return self.location.distance(from: location) / 1000
  }
}
