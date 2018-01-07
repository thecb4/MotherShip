//
//  Platform.swift
//  MotherShip
//
//  Created by Cavelle Benjamin on 18-Jan-07 (01).
//

import Foundation
import HyperSpace

public enum Platform: String {
  
  case ios
  
  
}

extension Platform: RoutePathComponent {
  public var stringValue: String {
    return self.rawValue
  }
  
  
}
