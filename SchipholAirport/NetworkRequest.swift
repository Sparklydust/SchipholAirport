//
//  ResourceRequest.swift
//  SchipholAirport
//
//  Created by Roland Lariotte on 30/10/2020.
//

import Foundation

//  MARK: NetworkRequest
/// Rest api call with any type as set in Resource.
///
struct NetworkRequest<Resource> where Resource: Codable {

  var resourceURL: NetworkEndpoint

  /// Parameter for testing purpose.
  ///
  /// When testing, insert MockURLSession instead.
  ///
  var resourceSession: URLSessionProtocol

  init(_ resourceURL: NetworkEndpoint,
       resourceSession: URLSessionProtocol = URLSession.shared) {
    self.resourceURL = resourceURL
    self.resourceSession = resourceSession
  }
}

extension NetworkRequest {
  /// Get request with an array as a response.
  ///
  func getArray(_ completion: @escaping (RequestArrayResult<Resource>) -> Void) {

    let dataTask = resourceSession.dataTask(with: resourceURL.url) { data, response, _ in
      guard let httpResponse = response as? HTTPURLResponse else {
        return completion(.failure)
      }
      guard httpResponse.statusCode == 200,
            let jsonData = data else {
        return completion(.failure)
      }
      do {
        let resources = try JSONDecoder().decode([Resource].self,
                                                 from: jsonData)
        completion(.success(resources))
      }
      catch {
        completion(.failure)
      }
    }
    dataTask.resume()
  }
}
