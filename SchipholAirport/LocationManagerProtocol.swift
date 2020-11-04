//
//  LocationManagerProtocol.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 04/11/2020.
//

import CoreLocation

//  MARK: LocationManagerProtocol
/// Rewrite value from CLLocationManager for testing
/// purposes.
///
protocol LocationManagerProtocol {

  var location: CLLocation? { get }
  var delegate: CLLocationManagerDelegate? { get set }
  var desiredAccuracy: CLLocationDistance { get set }
  var allowsBackgroundLocationUpdates: Bool { get set }

  func requestWhenInUseAuthorization()
  func requestAlwaysAuthorization()
  func startUpdatingLocation()
  func stopUpdatingLocation()
  func requestLocation()
}
