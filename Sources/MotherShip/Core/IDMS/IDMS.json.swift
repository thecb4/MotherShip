//
//  IDMS.json.swift
//  MothershipPackageDescription
//
//  Created by Cavelle Benjamin on 17-Dec-26 (53).
//

import Foundation

public struct LoginCredentials: Codable {
  
  public let accountName: String
  
  let password: String
  
  let rememberMe: Bool
  
  public init(accountName:String = "", password:String = "", rememberMe:Bool = true) {
    self.accountName = accountName
    self.password    = password
    self.rememberMe  = rememberMe
  }
  
}

public struct AuthenticationInfo: Codable {
  
  let authType: String
  
  init(authType:String = "") {
    self.authType = authType
  }
  
}
