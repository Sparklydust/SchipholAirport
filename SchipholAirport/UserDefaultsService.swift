//
//  UserDefaultsService.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 02/11/2020.
//

import Foundation

//  MARK: UserDefaultsService
/// Handles all UserDefaults values by saving
/// and retrieving them in source code.
///
/// UserDefaultsContainer parameter is used for testing
/// purposes to mock the container.
///
final class UserDefaultsService {
  static let shared = UserDefaultsService()

  /// Parameter for testing purposes.
  ///
  var userDefaultsContainer: UserDefaultsProtocol
  init(userDefaultsContainer: UserDefaultsProtocol = UserDefaultsContainer()) {
    self.userDefaultsContainer = userDefaultsContainer
  }
}

// MARK: - Containers
extension UserDefaultsService {
  /// Track user settings for distance unit.
  ///
  var isInKm: Bool {
    get {
      userDefaultsContainer.isInKm
    }
    set {
      userDefaultsContainer.isInKm = newValue
    }
  }
}
