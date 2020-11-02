//
//  MockURLSessionDataTask.swift
//  SchipholAirportTests
//
//  Created by Roland Lariotte on 30/10/2020.
//

import Foundation

//  MARK: MockURLSessionDataTask
/// Mock url session data task to fake completion handler
/// response.
///
final class MockURLSessionDataTask: URLSessionDataTask {

  var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?

  var data: Data?
  var urlResponse: URLResponse?
  var responseError: Error?

  override func resume() {
    completionHandler?(data, urlResponse, responseError)
  }

  override func cancel() {}
}
