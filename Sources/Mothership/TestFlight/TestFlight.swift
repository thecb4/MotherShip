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
  
}
