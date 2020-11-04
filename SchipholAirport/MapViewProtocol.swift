//
//  MapViewProtocol.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 04/11/2020.
//

import MapKit

//  MARK: MapViewProtocol
/// Rewrite value from MKMApView for testing purposes.
///
protocol MapViewProtocol {

  var showsUserLocation: Bool { get set }

  var translatesAutoresizingMaskIntoConstraints: Bool { get set }
  var topAnchor: NSLayoutYAxisAnchor { get }
  var leadingAnchor: NSLayoutXAxisAnchor { get }
  var trailingAnchor: NSLayoutXAxisAnchor { get }
  var bottomAnchor: NSLayoutYAxisAnchor { get }

  func setRegion(_ region: MKCoordinateRegion, animated: Bool)
}
