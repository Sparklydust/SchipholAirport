//
//  MockMKMapView.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 04/11/2020.
//

import MapKit
@testable import SchipholAirport

final class MockMKMapView: MapViewProtocol {

  var showsUserLocation = true

  var translatesAutoresizingMaskIntoConstraints = false

  var topAnchor = NSLayoutYAxisAnchor()
  var leadingAnchor = NSLayoutXAxisAnchor()
  var trailingAnchor = NSLayoutXAxisAnchor()
  var bottomAnchor = NSLayoutYAxisAnchor()

  func setRegion(_ region: MKCoordinateRegion, animated: Bool) { }
}
