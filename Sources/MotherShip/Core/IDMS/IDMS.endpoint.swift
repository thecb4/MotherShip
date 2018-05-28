//
//  IDMS.endpoint.swift
//  Mothership
//
//  Created by Cavelle Benjamin on 18-Jan-04 (01).
//

import Foundation
import HyperSpace

/// Identity Management System end point.
/// End point for signing in to iTunes Connect
struct IDMSEndPoint: EndpointType {
  
  enum Route: RouteType {
    func mockHTTPResponse(url: URL, statusCode: HTTPStatusCode) -> HTTPURLResponse? {
      return nil
    }
    
    
    // https://idmsa.apple.com/appleauth/auth/signin
    /// Route case for sign in. Must include Service Key information
    /// Credentials are passed as JSON body to URL
    case signIn(credentials: LoginCredentials, serviceKey: OlympusServiceKeyInfo)
    
    var route: URL.Route {
      switch self {
        
      case  .signIn:
        return URL.Route(path: ["auth","signin"])

      }
    }
    
    var method: URL.Method {
      switch self {
      case .signIn:
        return .post
      }
    }
    
    var headers: [HTTPHeader] {
      switch self {
      case .signIn(_, let serviceKey):
        return [
          HTTPHeader(field:"Content-Type", value:"application/json"),
          HTTPHeader(field:"X-Requested-With", value:"XMLHttpRequest"),
          HTTPHeader(field:"X-Apple-Widget-Key", value: serviceKey.authServiceKey),
          HTTPHeader(field:"Accept", value: "application/json, text/javascript")
        ]
      }
    }
    
    var body: Data? {
      switch self {
        case .signIn(let credentials, _ ):
          return try? JSONEncoder().encode(credentials)
      }
    }
    
    var mockResponseData: Data {
      switch self {
        case .signIn:
          return "{\"authType\": \"sa\"}".data(using: String.Encoding.utf8)!
      }
    }
    
  }
  
  static let current = URL.Env(.https, "idmsa.apple.com").at("appleauth")
  
}
