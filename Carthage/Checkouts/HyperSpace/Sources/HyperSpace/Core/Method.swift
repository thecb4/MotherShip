//
//  Method.swift
//  HyperSpace
//
//  Created by Cavelle Benjamin on 17-Dec-30 (53).
//

import Foundation

public extension URL {
  public struct Method: RawRepresentable {
    public let rawValue: String
    
    public init(_ rawValue: String) {
      self.init(rawValue: rawValue)
    }
    
    public init(rawValue: String) {
      self.rawValue = rawValue
    }
  }
}

public extension URL.Method {
  public static let options = URL.Method("OPTIONS")
  public static let get     = URL.Method("GET")
  public static let head    = URL.Method("HEAD")
  public static let post    = URL.Method("POST")
  public static let put     = URL.Method("PUT")
  public static let delete  = URL.Method("DELETE")
  public static let trace   = URL.Method("TRACE")
  public static let connect = URL.Method("CONNECT")
}

extension URL.Method: Hashable {
  public var hashValue: Int {
    return rawValue.hashValue
  }
  
  public static func == (lhs: URL.Method, rhs: URL.Method) -> Bool {
    return lhs.rawValue == rhs.rawValue
  }
}
