//
//  TestFlight.swift
//  Mothership
//
//  Created by Cavelle Benjamin on 17-Dec-26 (53).
//

import Foundation
import HyperSpace
import Result

typealias ResponseValue<T> = Result<T,URL.ResponseError>

public class TestFlight {

  public var debug = false
  
  let mothership: MotherShip
  
  public init() {
    mothership        = MotherShip()
  }

  /// Allows the user to be logged in to iTunes Connect.
  /// Under the hood, the default URLSession is used to manage cookies, etc.
  ///
  /// - returns: no return values
  /// - parameter credentials: The login credentials of the iTunes Connect user
  /// - throws: no errors thrown
  public func login(with credentials: LoginCredentials) throws {
    
    try self.mothership.login(with: credentials)

    if(self.debug) {
      print("serviceKeyInfo = \(self.mothership.olympusServiceKeyInfo)")
    }

  }
  
  public func groups(`for` appID: AppIdentifier, `in` teamID: TeamIdentifier) -> [Group] {
    
    let router = Router<TestFlightEndPoint>(at:
      .groups(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        appID: appID,
        teamID: teamID
      )
    )
    
    let resolve = router.resolve()
    
    let result: ResponseValue<Groups> = resolve.json()
    
    switch result {
      case .success( let value ):
        if(self.debug) {
          print("groups = \(value.data)")
        }
        return value.data
      case .failure( _ ):
        return []
    }
    
  }
  
  public func testers(`for` appID: AppIdentifier, `in` teamID: TeamIdentifier) -> [Tester] {
    
    let router = Router<TestFlightEndPoint>(at:
      .testers(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        appID: appID,
        teamID: teamID
      )
    )
    
    let resolve = router.resolve()
    
    let result: ResponseValue<Testers> = resolve.json()
    
    switch result {
    case .success( let value ):
      return value.data
    case .failure( _ ):
      return []
    }
    
  }
  
  public func invite(tester: Tester, to appID: AppIdentifier, `for` teamID: TeamIdentifier, groupName: String) -> HTTPStatusCode {

    let appAddEndPoint = Router<TestFlightEndPoint>(at:
      .addTesterToApp(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        tester: tester,
        appID: appID,
        teamID: teamID
      )
    )
    
    // should be safe. Only ever one default group
    guard let group = (self.groups(for: appID, in: teamID).filter{ $0.name == groupName }).first else {
      print("failed to get the group")
      return HTTPStatusCode(400)
    }

    if(self.debug) {
      print("adding \(tester.firstName) to group \(group.name)")
    }
 
    let groupAddEndPoint = Router<TestFlightEndPoint>(at:
      .addTesterToTestGroup(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        tester: tester,
        groupID: group.id,
        appID: appID,
        teamID: teamID
      )
    )
    
    let appAddResolve    = appAddEndPoint.resolve()
    let appStatusCodeResult = appAddResolve.httpStatusCode

    if(self.debug) {
      print(appAddResolve)
      print(appStatusCodeResult)
    }
    
    switch appStatusCodeResult {
      
      // if I add to the app successfully, then add to the group
      case .success(let appCode):
        
        // We want a 201 code, not 200
        if appCode == HTTPStatusCode(201) {
          
          let groupAddResolve       = groupAddEndPoint.resolve()
          let groupStatusCodeResult = groupAddResolve.httpStatusCode

          if(self.debug) {
            print(groupAddResolve)
            print(groupStatusCodeResult)
          }

          
          switch groupStatusCodeResult {
            
            case .success(let groupCode):
              return groupCode
            
            case .failure(_):
              return HTTPStatusCode(0)
          }
          
        } else {
          
          return appCode
        
      }
      
      case .failure(_):
        
        return HTTPStatusCode(0)
      
    }

  }
  
  public func versions(`for` appID: AppIdentifier, `in` teamID: TeamIdentifier, on platform: Platform) -> [Version] {
    
    let router = Router<TestFlightEndPoint>(at:
      .versions(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        appID: appID,
        teamID: teamID,
        platform: platform
      )
    )
    
    let resolve = router.resolve()
    
    let result: ResponseValue<Versions> = resolve.json()
    
    switch result {
    case .success( let value ):
      return value.data
    case .failure( _ ):
      return []
    }
    
  }
  
  public func builds(of version: Version, `for` appID: AppIdentifier, `in` teamID: TeamIdentifier, on platform: Platform) -> [BuildBrief] {
    
    let router = Router<TestFlightEndPoint>(at:
      .builds(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        version: version,
        appID: appID,
        teamID: teamID,
        platform: platform
      )
    )
    
    let resolve = router.resolve()
    
    let result: ResponseValue<BuildBriefs> = resolve.json()
    
    switch result {
    case .success( let value ):
      return value.data
    case .failure( _ ):
      return []
    }
    
  }
  
  public func build(buildNumber: BuildNumber, version: Version, `for` appID: AppIdentifier, `in` teamID: TeamIdentifier, on platform: Platform) -> BuildTestInfo? {
    
    let builds = self.builds(of: version, for: appID, in: teamID, on: platform)
    
    guard let brief: BuildBrief = (builds.filter { $0.buildVersion == buildNumber }.first) else { return nil }
    
    let router = Router<TestFlightEndPoint>(at:
      .build(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        appID: appID,
        teamID: teamID,
        buildID: brief.id
      )
    )
    
    let resolve = router.resolve()
    
    let result: ResponseValue<BuildDetails> = resolve.json()
    
    switch result {
    case .success( let value ):
      return value.data
    case .failure( _ ):
      return nil
    }
    
  }
  
  public func latestBuild(of version: Version, `for` appID: AppIdentifier, `in` teamID: TeamIdentifier, on platform: Platform){
  
    let builds = self.builds(of: version, for: appID, in: teamID, on: platform)
    
    // https://stackoverflow.com/questions/30417960/swift-array-sorting-error-when-sorting-by-date
    let sortedBuilds = builds.sorted { $0.uploadDate.compare($1.uploadDate) == .orderedAscending }
    
    guard let latest = sortedBuilds.last else { return }
    
    print(latest)
  
  }
  
  public func testInfo(for appID: AppIdentifier, in teamID: TeamIdentifier) -> AppTestInfo? {
    
    let router = Router<TestFlightEndPoint>(at:
      .appTestInfo(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        appID: appID,
        teamID: teamID
      )
    )
    
    let resolve = router.resolve()
    
    let result: ResponseValue<TestInfos> = resolve.json()
    
    switch result {
    case .success( let value ):
      return value.data
    case .failure( _ ):
      return nil
    }
    
  }
  
  public func updateAppTestInfo(with info: AppTestInfo, for appID: AppIdentifier, in teamID: TeamIdentifier) -> HTTPStatusCode {
    
    let router = Router<TestFlightEndPoint>(at:
      .updateAppTestInfo(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        info: info,
        appID: appID,
        teamID: teamID
      )
    )
    
    let resolve = router.resolve()
    
    let result = resolve.httpStatusCode
    
    switch result {
    case .success( let code ):
      return code
    case .failure( _ ):
      return HTTPStatusCode(0)
    }
    
  }
  
  public func updateBuildTestInfo(with info: BuildTestInfo, for appID: AppIdentifier, in teamID: TeamIdentifier) -> HTTPStatusCode {
    
    let router = Router<TestFlightEndPoint>(at:
      .updateBuildTestInfo(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        info: info,
        appID: appID,
        teamID: teamID
      )
    )
    
    let resolve = router.resolve()
    
    let result = resolve.httpStatusCode
    
    switch result {
    case .success( let code ):
      return code
    case .failure( _ ):
      return HTTPStatusCode(0)
    }
    
  }
  
}
