//
//  OlympusService.swift
//  MothershipPackageDescription
//
//  Created by Cavelle Benjamin on 17-Dec-25 (53).
//

import Foundation
import HyperSpace
import Result

/// Top 
public class MotherShip {

  public var debug = false
  
  /// EndPoint for obtaining the iTunes Connect Service Key
  let olympusServiceKeyEndPoint = Router<OlympusEndPoint>(at: .serviceKey)
  
  /// Service Key struct to hold the service key to pass in HTTP Header
  var olympusServiceKeyInfo:OlympusServiceKeyInfo
  
  /// EndPoint for obtaining the iTunes Connect Session information
  /// This information is stored in the default URLSession
  // let olympusSessionEndPoint    = Router<OlympusEndPoint>(at: .session)

  /// Developer Session struct. Unused as all data sits in URLSession
  // var devSession:DeveloperSession
  
  
  /// Allows the user to be logged in to iTunes Connect.
  /// Under the hood, the default URLSession is used to manage cookies, etc.
  ///
  /// - returns: no return values
  /// - parameter credentials: The login credentials of the iTunes Connect user
  /// - throws: throws errors for attempting to login. Users of the library should handle
  public func login(with credentials: LoginCredentials) throws {

      
    let serviceKeyResolve = olympusServiceKeyEndPoint.resolve()
    olympusServiceKeyInfo = try serviceKeyResolve.json().dematerialize()
    
    let resolve = Router<IDMSEndPoint>(at: .signIn(credentials: credentials, serviceKey: olympusServiceKeyInfo)).resolve()

    if(self.debug) {
      print("\(resolve)")
    }
    
    // let sessionResolve = olympusSessionEndPoint.resolve()
    // devSession = try sessionResolve.json().dematerialize()

  }
  
  /// No parameter init for MotherShip
  public init() {
    
    olympusServiceKeyInfo = OlympusServiceKeyInfo()
    // devSession            = DeveloperSession()
    
  }
  
}
