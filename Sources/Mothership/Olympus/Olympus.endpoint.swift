//
//  Olympus.endpoint.swift
//  Mothership
//
//  Created by Cavelle Benjamin on 17-Dec-31 (53).
//

import Foundation
import HyperSpace

struct OlympusEndPoint: EndpointType {
  
  enum Route: RouteType {
    
    // https://olympus.itunes.apple.com/v1/app/config?hostname=itunesconnect.apple.com
    case serviceKey
    
    // https://olympus.itunes.apple.com/v1/session
    case session
    
    var route: URL.Route {
      switch self {
        
        case  .serviceKey:
          return URL.Route(path: ["app","config"]).query(("hostname","itunesconnect.apple.com"))
        
        case .session:
          return URL.Route(path: ["session"])
        
      }
    }
    
    var method: URL.Method {
      switch self {
      case .serviceKey, .session:
        return .get
      }
    }
    
    var headers: [HTTPHeader] {
      switch self {
      case .serviceKey, .session:
        return []
      }
    }
    
    var body: Data? {
      switch self {
        case .serviceKey, .session:
          return nil
      }
    }
    
    var mockResponseData: Data {
      switch self {
      case .serviceKey:
        return "{\"status\": \"success\"}".data(using: String.Encoding.utf8)!
      case .session:
        return "{\"status\": \"success\"}".data(using: String.Encoding.utf8)!
      }
    }
    
  }
  
  static let current = URL.Env(.https, "olympus.itunes.apple.com").at("v1")
  
}
