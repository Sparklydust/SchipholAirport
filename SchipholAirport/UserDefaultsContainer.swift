//
//  UserDefaultsContainer.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 02/11/2020.
//

import Foundation

//  MARK: UserDefaultsContainer
/// Container to handle UserDefaults values.
///
/// Getting or settings value inside user defaults
/// to set in UserDefaultsServcie class. This container
/// is mocked to be tested.
///
final class UserDefaultsContainer {

  /// Key value to access user defaults elements.
  ///
  struct Key {
    static let isInKm = "isInKm"
  }

  /// Default value at app first launch for the
  /// isInKm app Settings.
  ///
  let IsInKmDefaultValue = "true"

  init() {
    // Initialize with default value when application
    // starts if none has been saved for Key.isInKm.
    //
    UserDefaults
      .standard
      .register(defaults: [Key.isInKm: IsInKmDefaultValue])
  }
}

// MARK: - Containers
extension UserDefaultsContainer: UserDefaultsProtocol {
  /// Track user settings for distance unit.
  ///
  var isInKm: Bool {
    get {
      UserDefaults
        .standard
        .bool(forKey: Key.isInKm)
    }
    set {
      UserDefaults
        .standard
        .setValue(newValue, forKey: Key.isInKm)
    }
  }
}
