//
//  Resource.swift
//  MotherShip
//
//  Created by Cavelle Benjamin on 18-May-07 (19).
//

import Foundation

class Resource {
  static var resourcePath = "./Tests/Resources/private"
  
  let name: String
  let type: String
  
  init(name: String, type: String) {
    self.name = name
    self.type = type
  }
  
  var path: String {
    guard let path: String = Bundle(for: Swift.type(of: self)).path(forResource: name, ofType: type) else {
      let filename: String = type.isEmpty ? name : "\(name).\(type)"
      return "\(Resource.resourcePath)/\(filename)"
    }
    return path
  }
}
