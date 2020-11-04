//
//  MapViewModel.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 04/11/2020.
//

import CoreLocation
import MapKit

//  MARK: MapViewModel
/// Handle the map view and the user location manager.
///
/// Populate user and airports locations on map view.
/// for testing purposes, locationManager and mapView
/// parameters where added.
///
final class MapViewModel: NSObject {

  // UI
  let identifier = "AirportAnnotation"
  var detailDisclosureButton = UIButton()
  var annotationView: MKAnnotationView?

  // Reference Types
  var airportsDownloader = NetworkRequest<AirportData>(.airports)
  var airports = [AirportData]()

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

// MARK: - Algorithms
extension MapViewModel {
  func populateAnnotations(_ airports: [AirportData]) {
    for a in airports {
      let annotation = MKPointAnnotation()
      annotation.title = a.name
      annotation.coordinate = CLLocationCoordinate2D(latitude: a.latitude,
                                                     longitude: a.longitude)
      mapView.addAnnotation(annotation)
    }
  }
}

// MARK: - Main Location Manager and Map Setup
extension MapViewModel {
  /// Start updating the map with the user info and
  /// airports location.
  ///
  func startMapping() {
    setupLocationManager()
    setupMapView()
  }
}

// MARK: - MapViewModel Setup
extension MapViewModel {
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
    mapView.delegate = self
    mapView.showsUserLocation = true
    downloadAirports()
    setupDetailDisclosureButton()
  }
}

// MARK: - Networking
extension MapViewModel {
  /// Download airports from flightassets api.
  ///
  /// The completion with @escaping is used to pass expectation
  /// in tests mainly.
  ///
  func downloadAirports(_ completion: @escaping () -> Void = { }) {
    airportsDownloader.getArray { response in
      switch response {
      case .failure:
        DispatchQueue.main.async {
          completion()
        }
        return
      case .success(let airports):
        DispatchQueue.main.async { [weak self] in
          guard let self = self else { return }
          self.handleDownloadSuccess(airports)
          completion()
        }
        return
      }
    }
  }

  /// Handling downloading airports data success from api call.
  ///
  func handleDownloadSuccess(_ airportsData: [AirportData]) {
    airports = airportsData
    populateAnnotations(airportsData)
  }
}

// MARK : - Location Manager
extension MapViewModel: CLLocationManagerDelegate {
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

// MARK: - Map View
extension MapViewModel: MKMapViewDelegate {
  // Add airport annotation on map view.
  //
  func mapView(_ mapView: MKMapView,
               viewFor annotation: MKAnnotation) -> MKAnnotationView? {

    guard !annotation.isKind(of: MKUserLocation.self) else {
      return nil
    }
    annotationView = mapView
      .dequeueReusableAnnotationView(withIdentifier: identifier)
    if annotationView == nil {
      annotationView = MKAnnotationView(annotation: annotation,
                                        reuseIdentifier: identifier)
      annotationView?.rightCalloutAccessoryView = detailDisclosureButton
      annotationView?.canShowCallout = true
    }
    else {
      annotationView?.annotation = annotation
    }

    annotationView?.image = .flightAnnotation

    return annotationView
  }

  /// Setup button shown when annotion is tapped.
  ///
  /// User to populate airports details informations
  /// on tap.
  ///
  func setupDetailDisclosureButton() {
    detailDisclosureButton = UIButton(type: .detailDisclosure)
    detailDisclosureButton.tintColor = .accentColor$
    detailDisclosureButton.addTarget(self,
                                     action: #selector(detailDisclosureTapped),
                                     for: .touchUpInside)
  }

  /// Perform actions when the detail disclosure from
  /// annotation is tapped.
  ///
  @objc func detailDisclosureTapped() {

  }
}
