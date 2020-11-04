//
//  LocationProvider.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 04/11/2020.
//

import CoreLocation
import MapKit

//  MARK: LocationProvider
/// Handle the map view and the user location manager.
///
/// Populate user and airports locations on map view.
/// for testing purposes, locationManager and mapView
/// parameters where added.
///
final class LocationProvider: NSObject {

  // Constants
  let aroundUserDistance: CLLocationDistance = 500000

  // Parameters and initializations for testing purposes.
  //
  var locationManager: LocationManagerProtocol
  var mapView: MapViewProtocol
  init(locationManager: LocationManagerProtocol = CLLocationManager(),
       mapView: MapViewProtocol = MKMapView()) {
    self.mapView = mapView
    self.locationManager = locationManager
  }
}

// MARK: - Location Manager and Map Setup
extension LocationProvider {
  /// Start updating the map with the user info and
  /// airports location.
  ///
  func startTracking() {
    setupLocationManager()
    setupMapView()
  }
}

// MARK: - LocationProvider Setup
extension LocationProvider: CLLocationManagerDelegate {
  /// Setup location manager delegation.
  ///
  func setupLocationManager() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestAlwaysAuthorization()
    locationManager.requestLocation()
    locationManager.startUpdatingLocation()
    locationManager.allowsBackgroundLocationUpdates = false
  }

  /// Setup map view to show elements on it.
  ///
  func setupMapView() {
    mapView.showsUserLocation = true
  }
}

// MARK : - Location manager
extension LocationProvider {
  // Action when user change their authorization status.
  //
  func locationManager(_ manager: CLLocationManager,
                       didChangeAuthorization status: CLAuthorizationStatus) {

    switch status {
    case .authorizedAlways:
      locationManager.startUpdatingLocation()
      return
    case .notDetermined:
      locationManager.requestAlwaysAuthorization()
      return
    default: ()
    }
  }

  // Center view around user when location update.
  //
  func locationManager(_ manager: CLLocationManager,
                       didUpdateLocations locations: [CLLocation]) {

    guard let location = locations.last else { return }
    let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                        longitude: location.coordinate.longitude)
    let region = MKCoordinateRegion.init(center: center,
                                         latitudinalMeters: aroundUserDistance,
                                         longitudinalMeters: aroundUserDistance)

    mapView.setRegion(region, animated: true)
  }

  // Actions on location manager failures.
  //
  func locationManager(_ manager: CLLocationManager,
                       didFailWithError error: Error) {
    locationManager.stopUpdatingLocation()
  }
}
