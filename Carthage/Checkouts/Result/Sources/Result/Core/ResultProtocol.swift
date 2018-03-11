//
//  ResultProtocol.swift
//  Result
//
//  Created by Cavelle Benjamin on 18-Jan-14 (02).
//

import Foundation

//  Copyright (c) 2015 Rob Rix. All rights reserved.
/// A protocol that can be used to constrain associated types as `Result`.
public protocol ResultProtocol {
  associatedtype Value
  associatedtype Error: Swift.Error
  
  init(value: Value)
  init(error: Error)
  
  var result: Result<Value, Error> { get }
}
