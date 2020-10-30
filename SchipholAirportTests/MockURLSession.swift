//
//  MockURLSession.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 30/10/2020.
//

import Foundation
@testable import SchipholAirport

final class MockURLSession: URLSessionProtocol {

  var data: Data?
  var response: URLResponse?
  var error: Error?

  init(data: Data?, response: URLResponse?, error: Error?) {
    self.data = data
    self.response = response
    self.error = error
  }

  func dataTask(with url: URL,
                completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
  -> URLSessionDataTask {
    let task = MockURLSessionDataTask()
    task.completionHandler = completionHandler
    task.data = data
    task.urlResponse = response
    task.responseError = error
    return task
  }
}
