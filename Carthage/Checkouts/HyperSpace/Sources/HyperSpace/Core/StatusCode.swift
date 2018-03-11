//
//  StatusCode.swift
//  HyperSpace
//
//  Created by Cavelle Benjamin on 18-Jan-10 (02).
//

import Foundation

// https://stackoverflow.com/questions/32102936/how-do-you-enumerate-optionsettype-in-swift

public struct HTTPStatusCode: OptionSet {
  
  public let rawValue: Int
  
  public init(rawValue: Int) {
    self.rawValue = rawValue
  }
  
  public init(_ rawValue: Int) {
    self.rawValue = rawValue
  }
  
  // 2xx Success
  public static let ok       = HTTPStatusCode(200)
  public static let created  = HTTPStatusCode(201)
  public static let accepted = HTTPStatusCode(202)
  public static let success  = [ok, created, accepted]
  
  // 4xx Client Error
  public static let badRequest   = HTTPStatusCode(400)
  public static let unauthorized = HTTPStatusCode(401)
  
  
  
}
