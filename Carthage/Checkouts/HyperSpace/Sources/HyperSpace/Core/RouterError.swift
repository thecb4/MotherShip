//
//  RouterError.swift
//  HyperSpace
//
//  Created by Cavelle Benjamin on 18-Jan-15 (03).
//

import Foundation

public extension URL {
  public enum RouterError: Swift.Error {
    case contactFailure(message: String)
  }
  
  public enum ResponseError: Swift.Error {
    case noDataPresent
    case decodeFailure(String)
  }
  
}
