//
//  URLSession+Protocol.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 30/10/2020.
//

import Foundation

//  MARK: URLSession+Protocol
/// Set URLSession to conform to URLSessionProtocol
/// for testing purposes.
///
/// URLSessionProtocol as a function similar to
/// URLSession.dataTask(url:completionHandler:)
/// to perform tests. We add URLSessionProtocol as
/// a protocol to URLSession for having this new
/// function enabled.
///
extension URLSession: URLSessionProtocol {}
