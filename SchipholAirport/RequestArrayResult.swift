//
//  RequestArrayResult.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 30/10/2020.
//

import Foundation

//  MARK: RequestArrayResult
/// Result for the completion handler of a
/// NetworkRequest.
///
/// Fetch an array of any type if succeed or
/// a failure.
///
enum RequestArrayResult<Resource> {

  case success([Resource])
  case failure
}
