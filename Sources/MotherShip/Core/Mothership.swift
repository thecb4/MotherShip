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

  public let itcSession = URLSession(configuration: .default)
  
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

    self.itcSession.configuration.httpShouldSetCookies = true
    self.itcSession.configuration.httpCookieAcceptPolicy = .always
    self.itcSession.configuration.httpMaximumConnectionsPerHost = 6
    self.itcSession.configuration.httpCookieStorage = HTTPCookieStorage.shared

      
    let serviceKeyResolve = olympusServiceKeyEndPoint.resolve(with: self.itcSession)
    olympusServiceKeyInfo = try serviceKeyResolve.json().dematerialize()
    
    let resolve = Router<IDMSEndPoint>(at: .signIn(credentials: credentials, serviceKey: olympusServiceKeyInfo)).resolve(with: self.itcSession)


    guard let response = resolve.response as? HTTPURLResponse else {
      return
    }

    guard let headers = response.allHeaderFields as? [String:String] else {
      return
    }

    guard let url = response.url else {
      return
    }

    let cookies = HTTPCookie.cookies(withResponseHeaderFields: headers, for: url)

    if(self.debug) { 
      print(cookies)
    }

    for cookie in cookies {
      var cookieProperties = [HTTPCookiePropertyKey:Any]()
      cookieProperties[.name]    = cookie.name
      cookieProperties[.value]   = cookie.value
      cookieProperties[.domain]  = cookie.domain
      cookieProperties[.path]    = cookie.path
      cookieProperties[.version] = NSNumber(value: cookie.version)
      cookieProperties[.expires] = Date().addingTimeInterval(31536000)

      let newCookie = HTTPCookie(properties: cookieProperties)

      HTTPCookieStorage.shared.setCookie(newCookie!)
      // self.itcSession.configuration.httpCookieStorage?.setCookie(newCookie!)

      if(self.debug) {

        print("name: \(cookie.name) value: \(cookie.value)")

      }
    }

    // itcSession.configuration.httpCookieStorage? = HTTPCookieStorage.shared    

    if(self.debug) {
      
      print("\(resolve)")

//       let jar = NSHTTPCookieStorage.sharedHTTPCookieStorage()
// let cookieHeaderField = ["Set-Cookie": "key=value"] // Or ["Set-Cookie": "key=value, key2=value2"] for multiple cookies
// let cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(cookieHeaderField, forURL: url)
// jar.setCookies(cookies, forURL: url, mainDocumentURL: url)
      
      print("shared cookies = \(String(describing: HTTPCookieStorage.shared.cookies))")
      print("session cookies = \(String(describing: itcSession.configuration.httpCookieStorage?.cookies))")
      
//      guard let response = resolve.response as? HTTPURLResponse else {
//        return
//      }
//
//      guard let headers = response.allHeaderFields as? [String:String] else {
//        return
//      }
//
//      guard let url = response.url else {
//        return
//      }
//
//      let cookies = HTTPCookie.cookies(withResponseHeaderFields: headers, for: url)
//
//      print(cookies)
      
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
