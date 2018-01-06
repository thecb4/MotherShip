//
//  Request.extensions.swift
//  MothershipPackageDescription
//
//  Created by Cavelle Benjamin on 17-Dec-26 (53).
//

import Foundation

struct HTTP {
  enum Method: String {
    case get    = "GET"
    case put    = "PUT"
    case post   = "POST"
    case delete = "DELETE"
  }
}

extension URLRequest {
  
  var http_method: HTTP.Method {
    get {
      return HTTP.Method(rawValue: self.httpMethod!)!
    }
    set {
      self.httpMethod = newValue.rawValue
    }
  }
  
}
