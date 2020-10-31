//
//  Spinner.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 31/10/2020.
//

import UIKit

//  MARK: Spinner
/// UIActivityController custom class.
///
final class Spinner {

  var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
}

// MARK: - Spinner Actions
extension Spinner {
  /// Start spinner as an UIActivityController on view.
  ///
  func starts(on view: UIView) {
    mainDesignSetup(on: view)
    activityIndicator.startAnimating()
  }

  /// Stop the spinner and hides it from view.
  ///
  func stops() {
    activityIndicator.stopAnimating()
  }
}

// MARK: - Main Setup
extension Spinner {
  /// Main view setup with desing and layout.
  ///
  func mainDesignSetup(on view: UIView) {
    setupDesign(on: view)
    setupLayout(on: view)
  }

  /// Activity indicator UI design and add as subview.
  ///
  func setupDesign(on view: UIView) {
    activityIndicator.color = .accentColor$
    view.addSubview(activityIndicator)
  }

  /// Setup layout for the Spinner on parent view.
  ///
  /// Spinner is center to parent view ignoring top and
  /// bottom safe area.
  ///
  func setupLayout(on view: UIView) {
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false

    // activityIndicator
    //
    activityIndicator
      .centerXAnchor
      .constraint(equalTo: view.centerXAnchor)
      .isActive = true

    activityIndicator
      .centerYAnchor
      .constraint(equalTo: view.centerYAnchor)
      .isActive = true

    activityIndicator
      .topAnchor
      .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
      .isActive = true

    activityIndicator
      .bottomAnchor
      .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
      .isActive = true
  }
}
