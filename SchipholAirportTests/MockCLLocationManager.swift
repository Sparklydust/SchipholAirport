//
//  MockCLLocationManager.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 04/11/2020.
//

import CoreLocation
@testable import SchipholAirport

final class MockCLLocationManager: LocationManagerProtocol {

  var location: CLLocation? = CLLocation(latitude: 52.30907,
                                         longitude: 4.763385)
  var delegate: CLLocationManagerDelegate?
  var desiredAccuracy = kCLLocationAccuracyBest
  var allowsBackgroundLocationUpdates = true
  var showUserLocation = true

  func requestWhenInUseAuthorization() { }
  func requestAlwaysAuthorization() { }
  func startUpdatingLocation() { }
  func stopUpdatingLocation() { }
  func requestLocation() { }
}
