//
//  OlympusService.swift
//  MothershipPackageDescription
//
//  Created by Cavelle Benjamin on 17-Dec-25 (53).
//

import Foundation
import HyperSpace
public class MotherShip {
  
  let olympusServiceKeyEndPoint = Router<OlympusEndPoint>(at: .serviceKey)
  let olympusSessionEndPoint    = Router<OlympusEndPoint>(at: .session)
  
//  let olympusService:OlympusService
//  let idmsService:IDMSService
  
  var olympusServiceKeyInfo:OlympusServiceKeyInfo
  var devSession:DeveloperSession
  
  public func login(with credentials: LoginCredentials) {
    
    self.olympusServiceKeyInfo = olympusServiceKeyEndPoint.decodeJSON()!
    
    let idmsEndPoint = Router<IDMSEndPoint>(at: .signIn(credentials: credentials, serviceKey: self.olympusServiceKeyInfo))
    
    let authInfo: AuthenticationInfo = idmsEndPoint.decodeJSON()!

    self.devSession = olympusSessionEndPoint.decodeJSON()!
    
  }
  
  public init() {
//    olympusService = OlympusService()
//    idmsService    = IDMSService()
    
    olympusServiceKeyInfo = OlympusServiceKeyInfo()
    devSession            = DeveloperSession()
  }
  
  public var authenticationKey: String {
    return olympusServiceKeyInfo.authServiceKey
  }
  
}
