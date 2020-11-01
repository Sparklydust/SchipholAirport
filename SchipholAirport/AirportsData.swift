//
//  AirportsData.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 30/10/2020.
//

import Foundation
import CoreLocation

//  MARK: AirportsData
/// Airports data coming from the api.
///
/// Additional elements from the api are added to
/// AirportsData, the location and func distance(location:).
///
struct AirportsData: AirportsProtocol, Codable {

  var id: String
  var latitude: Double
  var longitude: Double
  var name: String
  var city: String
  var countryId: String

  /// Setup location of the airport.
  ///
  var location: CLLocation {
    return CLLocation(latitude: latitude,
                      longitude: longitude)
  }

  /// Calculate distance from two core location points.
  ///
  /// Used to calculate the distance between two airports.
  ///
  func distance(to location: CLLocation) -> CLLocationDistance {
    return self.location.distance(from: location)
  }
}
