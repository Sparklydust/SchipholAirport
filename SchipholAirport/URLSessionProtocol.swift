//
//  URLSessionProtocol.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 30/10/2020.
//

import Foundation

//  MARK: URLSessionProtocol
/// Rewrite func dataTask for testing purposes.
///
protocol URLSessionProtocol {
  func dataTask(with url: URL,
                completionHandler: @escaping (Data?,
                                              URLResponse?,
                                              Error?) -> Void) -> URLSessionDataTask
}
