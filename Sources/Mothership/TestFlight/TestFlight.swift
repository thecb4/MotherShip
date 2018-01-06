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
//  let testflightService: TestFlightService
  var devSession: DeveloperSession
  
  public init() {
    mothership        = MotherShip()
    devSession        = DeveloperSession()
//    testflightService = TestFlightService()
  }
  
  public func login(with credentials: LoginCredentials) {
    self.mothership.login(with: credentials)
    self.devSession = self.mothership.devSession
  }
  
  func groups(`for` appID: AppIdentifier, `in` teamID: TeamIdentifier) -> [Group] {
    
    let endPoint = Router<TestFlightEndPoint>(at:
      .groups(serviceKey: self.mothership.olympusServiceKeyInfo, appID: appID, teamID: teamID)
    )
    
    let groups: Groups = endPoint.decodeJSON()!
    
    return groups.data
    
  }
  
  func testers(`for` appID: AppIdentifier, `in` teamID: TeamIdentifier) -> [Tester] {
    
    let endPoint = Router<TestFlightEndPoint>(at:
      .testers(serviceKey: self.mothership.olympusServiceKeyInfo, appID: appID, teamID: teamID)
    )
    
    let testers: Testers = endPoint.decodeJSON()!
    
    return testers.data
    
  }
  
  func invite(tester: Tester, to appID: AppIdentifier, `for` teamID: TeamIdentifier) -> Int {
    
    let appAddEndPoint = Router<TestFlightEndPoint>(at:
      .addTesterToApp(
        serviceKey: self.mothership.olympusServiceKeyInfo,
        tester: tester,
        appID: appID,
        teamID: teamID
      )
    )
    
    let group = self.groups(for: appID, in: teamID).filter {$0.isDefaultExternalGroup == true }.first!
    
    let aStatusCode = appAddEndPoint.statusCodeOnly()
 
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
  
//  func add(tester: Tester, appID: AppIdentifier, teamID: TeamIdentifier, groupID:String = "") -> String {
//    
//    let _ = testflightService.add(tester: tester, appID: appID, teamID: teamID, with: mothership.authenticationKey)
//    
//    
//    return testflightService.add(to: groupID, tester: tester, appID: appID, teamID: teamID, with: mothership.authenticationKey)
//    
//  }
  
}
