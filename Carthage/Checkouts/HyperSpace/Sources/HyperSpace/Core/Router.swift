//
//  Router.swift
//  SweetRouter
//
//  Created by Oleksii on 17/03/2017.
//  Copyright © 2017 ViolentOctopus. All rights reserved.
//

import Foundation

public struct HTTPHeader {
  let field:String
  let value:String
  
  public init(field: String, value: String) {
    self.field = field
    self.value = value
  }
}

public struct Router<T: EndpointType>: URLRepresentable {
  
  public let environment: T.Environment
  public let route: T.Route
  
  public init(_ environment: T.Environment = T.current, at route: T.Route) {
      self.environment = environment
      self.route = route
  }
  
  public var components: URLComponents {
      var components = environment.components
      let route = self.route.route
    
      components.path = environment.value.defaultPath.with(route.path).pathValue
      components.queryItems = route.query?.queryItems
      components.fragment = route.fragment
    
      return components
  }
  
  public func resolve(with cachePolicy:URLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = 500, `for` session: URLSession = URLSession.shared) -> EndPointResult {
    
    let request = self.request()
    
    var _response: URLResponse?
    var _data: Data?
    var _error: Error?
    
    let _ = session.sendSynchronousRequest(with:request) {
      
      (data, response, error) -> Void in
      
        _response = response
        _data     = data
        _error    = error
    
    }
    
    return EndPointResult(response:_response, data:_data, error:_error)
    
  }
  
  public func request(with cachePolicy:URLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = 500) -> URLRequest {
    let url     = self.url
    let method  = self.route.method
    let headers = self.route.headers
    var request = URLRequest(url: url, cachePolicy:cachePolicy, timeoutInterval: timeoutInterval)
    
    request.httpMethod = method.rawValue
    
    if let body = self.route.body {
      request.httpBody = body
    }
    
    for header in headers {
      request.addValue(header.value, forHTTPHeaderField: header.field)
    }
    
    return request
  }
  
  @available(*, deprecated, message: "use resolve: instead")
  public func statusCodeOnly(with session: URLSession = URLSession.shared) -> HTTPStatusCode {
    
    var statusCode: Int = 0
    
    if HyperSpace.debug {
      
      statusCode = 0
      
    } else {
      
      let _ = session.sendSynchronousRequest(with:self.request()) {
        
        (data, response, error) -> Void in
        
        if (error != nil) {
          print(error!)
        } else {
          let httpResponse = response as! HTTPURLResponse
          print(httpResponse)
          
          statusCode = httpResponse.statusCode
          
        }
      }
    }
    
    return HTTPStatusCode(statusCode)
  }
  
  @available(*, deprecated, message:"use resolve: instead")
  public func decodeJSON<T: Decodable>(with session: URLSession = URLSession.shared) -> T? {

    var result:T?
    
    if HyperSpace.debug {
      
      result = try? JSONDecoder().decode(T.self, from: self.route.mockResponseData)
      
    } else {
    
      let _ = session.sendSynchronousRequest(with:self.request()) {
        
        (data, response, error) -> Void in
        
        if (error != nil) {
          print(error!)
        } else {
          let httpResponse = response as! HTTPURLResponse
          print(httpResponse)
          
          guard let data = data else { return }
          result = try? JSONDecoder().decode(T.self, from: data)

        }
      }
    }

    return result

  }
  
  @available(*, deprecated, message: "use resolve: instead")
  public func stringResult(with session: URLSession = URLSession.shared) -> String {
  
    var result = ""
  
    if HyperSpace.debug {
  
      result = ""
  
    } else {
  
    let _ = session.sendSynchronousRequest(with:self.request()) {
  
      (data, response, error) -> Void in
  
      if (error != nil) {
        print(error!)
      } else {
        let httpResponse = response as! HTTPURLResponse
        print(httpResponse)
  
        guard let data = data else { return }
        result = String(data: data, encoding: .utf8)!
  
        }
      }
    }
  
    return result
  }
  
}

public protocol URLRepresentable {
  var components: URLComponents { get }
  var url: URL { get }
}

public extension URLRepresentable {
  public var url: URL {
      guard let url = components.url else { fatalError("URL components are not valid") }
      return url
  }
}

public protocol EndpointType {
  associatedtype Environment: EnvironmentType
  associatedtype Route: RouteType
  
  static var current: Environment { get }
  
}

public protocol RouteType {
  var route: URL.Route { get }
  var method: URL.Method { get }
  var headers: [HTTPHeader] { get }
  var body: Data? { get }
  var mockResponseData: Data { get }
  
}

public protocol EnvironmentType: URLRepresentable {
    var value: URL.Env { get }
}

public extension EnvironmentType {
    public var components: URLComponents {
        var components = URLComponents()
        let environment = value
        
        components.scheme = environment.scheme.rawValue
        components.host = environment.host.hostString
        components.port = environment.port
        components.path = environment.defaultPath.pathValue
        
        return components
    }
}
