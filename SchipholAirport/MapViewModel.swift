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
  var annotationImage = UIImage()

  // Reference Types
  var airportsDownloader = NetworkRequest<AirportData>(.airports)
  var airports = [AirportData]()
  var aiportDetailsDict = [String: AirportDetailsData]()
  var furthestAirports = Set<AirportData>()
  let spinner = Spinner()

  // Constants
  let aroundUserDistance: CLLocationDistance = 500000
  static let airportDetailskey = "details"


  // Variables
  var isInKm = UserDefaultsService.shared.isInKm

  // Parameters and initializations for testing purposes.
  //
  var locationManager: LocationManagerProtocol
  var mapView: MapViewProtocol
  init(locationManager: LocationManagerProtocol = CLLocationManager(),
       mapView: MapViewProtocol = MKMapView()) {
    self.locationManager = locationManager
    self.mapView = mapView
  }
}

// MARK: - Algorithms
extension MapViewModel {
  /// Populate annotations with a custom image.
  ///
  func populateAnnotations(_ airports: [AirportData]) {
    for a in airports {
      let annotation = MKPointAnnotation()
      annotation.title = a.name
      annotation.coordinate = CLLocationCoordinate2D(latitude: a.latitude,
                                                     longitude: a.longitude)

      annotationImage = .flightAnnotation ?? UIImage()

      mapView.addAnnotation(annotation)
    }
  }

  /// Perform actions when the detail disclosure from
  /// annotation is tapped.
  ///
  /// Search for the annotation tapped and calculate the
  /// distance of the nearest airport after finding its name.
  /// airportsDistance is initialize at 100000 because we need
  /// a hight value to start for comparaison.
  ///
  /// - Parameters:
  ///     - view: annation that comes from calloutAccessoryControlTapped
  ///     map view method.
  /// - Returns: AirportDetailsData model for AirportDetailsVC
  ///
  func detailDisclosureTapped(on view: MKAnnotationView) -> AirportDetailsData? {
    var airportsDistance: Double = 100000
    var nearestAirport: AirportData?

    for a in airports {
      if a.name == view.annotation?.title {
        for b in airports {
          let distance = a.distance(isInKm, to: b.location)

          if distance < airportsDistance
              && a.id != b.id {

            airportsDistance = distance
            nearestAirport = b
          }
        }
        let airportDetails = AirportDetailsData(
          airportData: a,
          nearestAirport: nearestAirport?.name ?? "",
          airportsDistance: airportsDistance)

        return airportDetails
      }
    }
    return nil
  }

  /// Founfing airports that are the furthest apart on the map.
  ///
  /// Calculate the distance between airports in two different arrays. If airports are not the furthest, one of the array delete the non needed
  /// airport.
  ///
  func foundAirportsFurthestApart() {
    var distance: CLLocationDistance = .zero
    let x = airports.reversed()
    var y = airports

    for a in x {
      for b in y {

        let d = a.distance(true, to: b.location)

        if d > distance {
          distance = d
          furthestAirports = []
          furthestAirports.insert(a)
          furthestAirports.insert(b)

          if let index = y.firstIndex(of: b) {
            y.remove(at: index)
          }
        }
      }
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
    spinner.starts(on: mapView as? UIView ?? UIView())

    airportsDownloader.getArray { response in
      switch response {
      case .failure:
        DispatchQueue.main.async {
          self.handleDownloadFailure()
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

  /// Handling downlading failure from api call.
  ///
  func handleDownloadFailure() {
    spinner.stops()
  }

  /// Handling downloading airports data success from api call.
  ///
  func handleDownloadSuccess(_ airportsData: [AirportData]) {
    spinner.stops()
    airports = airportsData
    foundAirportsFurthestApart()
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
    annotationView?.image = annotationImage

    return annotationView
  }

  // Action when the annoation info button is tapped.
  //
  // Check distance unit to before doing the algorithms search
  // and have the value in km or miles.
  //
  func mapView(_ mapView: MKMapView,
               annotationView view: MKAnnotationView,
               calloutAccessoryControlTapped control: UIControl) {
    checkDistanceUnitSettings()

    guard let aiportsDetails = detailDisclosureTapped(on: view) else { return }
    aiportDetailsDict = [MapViewModel.airportDetailskey: aiportsDetails]
    
    sendDataNotification(of: aiportDetailsDict)
    sendModalViewNotification()
  }

  /// Setup button shown when annotion is tapped.
  ///
  /// User to populate airports details informations
  /// on tap.
  ///
  func setupDetailDisclosureButton() {
    detailDisclosureButton = UIButton(type: .detailDisclosure)
    detailDisclosureButton.tintColor = .accentColor$
  }

  /// User distance unit set in settings.
  ///
  /// Retrieve the value from user defaults
  /// before calculating the distance between
  /// two airports.
  ///
  func checkDistanceUnitSettings() {
    isInKm = UserDefaultsService.shared.isInKm
  }
}

// MARK: Notifications
extension MapViewModel {
  /// Send notification to show AirportsVC a modal view.
  ///
  func sendModalViewNotification() {
    NotificationCenter
      .default
      .post(name: NSNotification
              .Name(rawValue: AirportsVC.detailsModalNotification),
            object: nil)
  }

  /// Send notification to AirportsVC with the airport details data
  /// inside it to share.
  ///
  func sendDataNotification(of aiportDetailsDict: [String: AirportDetailsData]) {
    NotificationCenter
      .default
      .post(name: NSNotification
              .Name(rawValue: AirportsVC.airportDetailsNotification),
            object: nil,
            userInfo: aiportDetailsDict)
  }
}
