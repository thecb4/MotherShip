//
//  EndPointResult.swift
//  HyperSpace
//
//  Created by Cavelle Benjamin on 18-Jan-15 (03).
//

import Foundation
import Result

// https://medium.com/@jamesrochabrun/protocol-based-generic-networking-using-jsondecoder-and-decodable-in-swift-4-fc9e889e8081

public struct EndPointResult {
  public let response: URLResponse?
  public let data: Data?
  public let error: Error?
  
  public init(response: URLResponse?, data: Data?, error: Error?) {
    self.response = response
    self.data     = data
    self.error    = error
  }
}

extension EndPointResult {
  
  public var responseString: Result<String, URL.RouterError> {
    guard let httpResponse = self.response as? HTTPURLResponse else {
      return .failure( .contactFailure(message:"no HTTP response detected") )
    }
    
    return .success(httpResponse.description)
  }
  
  public var httpStatusCode: Result<HTTPStatusCode, URL.RouterError> {

    guard let httpResponse = self.response as? HTTPURLResponse else {
      return .failure( .contactFailure(message:"no HTTP response detected") )
    }
    
    let code = HTTPStatusCode(httpResponse.statusCode)
    
    return .success(code)
  }
  
  public func json<T:Codable>() -> Result<T, URL.ResponseError> {
    guard let data = self.data else { return .failure( .noDataPresent ) }
    guard let result = try? JSONDecoder().decode(T.self, from: data) else { return .failure( .decodeFailure("\(T.self)") ) }
//    let result = try? JSONDecoder().decode(T.self, from: data)
    return .success(result)
  }
  
}
