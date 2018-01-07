//
//  TestFlight.endpoint.swift
//  Mothership
//
//  Created by Cavelle Benjamin on 17-Dec-31 (53).
//

import Foundation
import HyperSpace

struct TestFlightEndPoint: EndpointType {
  
  enum Route: RouteType {
    
    // get list of groups for app in team
    case groups(serviceKey: OlympusServiceKeyInfo, appID: AppIdentifier, teamID: TeamIdentifier)
    
    case testers(serviceKey: OlympusServiceKeyInfo, appID: AppIdentifier, teamID: TeamIdentifier)
  
    // add tester to app
    case addTesterToApp(serviceKey: OlympusServiceKeyInfo, tester: Tester, appID: AppIdentifier, teamID: TeamIdentifier)
    
    // add tester to test group
    case addTesterToTestGroup(serviceKey:OlympusServiceKeyInfo, tester: Tester, groupID: String, appID: AppIdentifier, teamID: TeamIdentifier)

    var route: URL.Route {
      switch self {
        case .groups( _, let appID, let teamID):
          // "https://itunesconnect.apple.com/testflight/v2/providers/\(teamID)/apps/\(appID)/groups"
          return URL.Route(path: ["providers",teamID,"apps",appID,"groups"])
        case .testers( _, let appID, let teamID):
          // "https://itunesconnect.apple.com/testflight/v2/providers/\(teamID)/apps/\(appID)/testers"
          return URL.Route(path: ["providers",teamID,"apps",appID,"testers"])
        case  .addTesterToApp(_, _, let appID, let teamID):
          // providers/\(teamID)/apps/\(appID)/testers"
          let route = URL.Route(path: ["providers",teamID,"apps",appID,"testers"])
          return route
          // providers/\(teamID)/apps/\(appID)/groups/\(groupID)/testers
        case .addTesterToTestGroup(_, _, let groupID, let appID, let teamID):
          // providers/\(teamID)/apps/\(appID)/testers"
          let route = URL.Route(path: ["providers",teamID,"apps",appID,"groups",groupID,"testers"])
          return route
      }
    }
    
    var method: URL.Method {
      switch self {
        case .groups, .testers:
          return .get
        case .addTesterToApp, .addTesterToTestGroup:
          return .post
      }
    }
    
    var headers: [HTTPHeader] {
      switch self {
        case .groups(let serviceKey, _, _),
             .testers(let serviceKey, _, _),
             .addTesterToApp(let serviceKey, _, _, _),
             .addTesterToTestGroup(let serviceKey, _, _, _, _):
          let headers =
            [
              HTTPHeader(field:"Content-Type", value:"application/json"),
              HTTPHeader(field:"X-Requested-With", value:"XMLHttpRequest"),
              HTTPHeader(field:"X-Apple-Widget-Key", value: serviceKey.authServiceKey),
              HTTPHeader(field:"Accept", value: "application/json, text/javascript")
             ]
          return headers
      }
    }
    
    var body: Data? {
      switch self {
      case .groups,.testers:
        return nil
      case .addTesterToApp(_, let tester, _, _):
        return try? JSONEncoder().encode(tester)
      case .addTesterToTestGroup(_, let tester, _, _, _):
        return try? JSONEncoder().encode([tester])
      }
    }
    
    var mockResponseData: Data {
      switch self {
      case .groups:
        return "{\"status\": \"success\"}".data(using: String.Encoding.utf8)!
      case .testers:
        return "{\"status\": \"success\"}".data(using: String.Encoding.utf8)!
      case .addTesterToApp:
        return "{\"status\": \"success\"}".data(using: String.Encoding.utf8)!
      case .addTesterToTestGroup:
        return "{\"status\": \"success\"}".data(using: String.Encoding.utf8)!
      }
    }
    
  }

  static let current = URL.Env(.https, "itunesconnect.apple.com").at("testflight","v2")

}

