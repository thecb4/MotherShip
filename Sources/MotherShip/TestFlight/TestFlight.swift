//
//  TestFlight.swift
//  Mothership
//
//  Created by Cavelle Benjamin on 17-Dec-26 (53).
//

import Foundation
import HyperSpace

public class TestFlight {
  
  let mothership: MotherShip
  var devSession: DeveloperSession
  
  public init() {
    mothership        = MotherShip()
    devSession        = DeveloperSession()
  }

  /// Allows the user to be logged in to iTunes Connect.
  /// Under the hood, the default URLSession is used to manage cookies, etc.
  ///
  /// - returns: no return values
  /// - parameter credentials: The login credentials of the iTunes Connect user
  /// - throws: no errors thrown
  public func login(with credentials: LoginCredentials) {
    self.mothership.login(with: credentials)
    self.devSession = self.mothership.devSession
  }
  
  public func groups(`for` appID: AppIdentifier, `in` teamID: TeamIdentifier) -> [Group] {
    
    let endPoint = Router<TestFlightEndPoint>(at:
      .groups(serviceKey: self.mothership.olympusServiceKeyInfo, appID: appID, teamID: teamID)
    )
    
    let groups: Groups = endPoint.decodeJSON()!
    
    return groups.data
    
  }
  
  public func testers(`for` appID: AppIdentifier, `in` teamID: TeamIdentifier) -> [Tester] {
    
    let endPoint = Router<TestFlightEndPoint>(at:
      .testers(serviceKey: self.mothership.olympusServiceKeyInfo, appID: appID, teamID: teamID)
    )
    
    let testers: Testers = endPoint.decodeJSON()!
    
    return testers.data
    
  }
  
  public func invite(tester: Tester, to appID: AppIdentifier, `for` teamID: TeamIdentifier) -> HTTPStatusCode {
    
    let appAddEndPoint = Router<TestFlightEndPoint>(at:
      .addTesterToApp(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        tester: tester,
        appID: appID,
        teamID: teamID
      )
    )
    
    let group = self.groups(for: appID, in: teamID).filter {$0.isDefaultExternalGroup == true }.first!
    
    let _ = appAddEndPoint.statusCodeOnly()
 
    let groupAddEndPoint = Router<TestFlightEndPoint>(at:
      .addTesterToTestGroup(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        tester: tester,
        groupID: group.id,
        appID: appID,
        teamID: teamID
      )
    )
    
    let bStatusCode = groupAddEndPoint.statusCodeOnly()
    
    return bStatusCode
    
  }
  
  public func versions(`for` appID: AppIdentifier, `in` teamID: TeamIdentifier, on platform: Platform) -> [Version] {
    
    let ep = Router<TestFlightEndPoint>(at:
      .versions(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        appID: appID,
        teamID: teamID,
        platform: platform
      )
    )
    
    let versions: Versions = ep.decodeJSON()!
    
    return versions.data
    
  }
  
  public func builds(version: Version, `for` appID: AppIdentifier, `in` teamID: TeamIdentifier, on platform: Platform) -> [Build] {
    
    let ep = Router<TestFlightEndPoint>(at:
      .builds(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        version: version,
        appID: appID,
        teamID: teamID,
        platform: platform
      )
    )
    
    print(ep.stringResult())
    
    let builds: Builds = ep.decodeJSON()!
    
    return builds.data
    
  }
  
  public func build(buildNumber: BuildNumber, version: Version, `for` appID: AppIdentifier, `in` teamID: TeamIdentifier, on platform: Platform) {
    
    let builds = self.builds(version: version, for: appID, in: teamID, on: platform)
    
    let build: Build = builds.filter { $0.buildVersion == buildNumber }.first!
    
    let ep = Router<TestFlightEndPoint>(at:
      .build(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        appID: appID,
        teamID: teamID,
        buildID: build.id
      )
    )
    
    print(ep.stringResult())
    
    
  }
  
  public func testInfo(for appID: AppIdentifier, in teamID: TeamIdentifier) -> AppTestInfo {
    
    let ep = Router<TestFlightEndPoint>(at:
      .appTestInfo(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        appID: appID,
        teamID: teamID
      )
    )
    
    let info: TestInfos = ep.decodeJSON()!
    
    return info.data
    
  }
  
  public func updateAppTestInfo(with info: AppTestInfo, for appID: AppIdentifier, in teamID: TeamIdentifier) -> HTTPStatusCode {
    
    let ep = Router<TestFlightEndPoint>(at:
      .updateAppTestInfo(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        info: info,
        appID: appID,
        teamID: teamID
      )
    )
    
    let statusCode = ep.statusCodeOnly()
    
    return statusCode
    
  }
  
}
