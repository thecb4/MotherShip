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
    func mockHTTPResponse(url: URL, statusCode: HTTPStatusCode) -> HTTPURLResponse? {
      return nil
    }
    
    
    // get list of groups for app in team
    case groups(serviceKey: OlympusServiceKeyInfo, appID: AppIdentifier, teamID: TeamIdentifier)
    
    case testers(serviceKey: OlympusServiceKeyInfo, appID: AppIdentifier, teamID: TeamIdentifier)
  
    // add tester to app
    case addTesterToApp(serviceKey: OlympusServiceKeyInfo, tester: Tester, appID: AppIdentifier, teamID: TeamIdentifier)
    
    // add tester to test group
    case addTesterToTestGroup(serviceKey:OlympusServiceKeyInfo, tester: Tester, groupID: String, appID: AppIdentifier, teamID: TeamIdentifier)
    
    // get build trains
    // "providers/#{team_id}/apps/#{app_id}/platforms/#{platform}/trains"
    case versions(serviceKey: OlympusServiceKeyInfo, appID: AppIdentifier, teamID: TeamIdentifier, platform: Platform)
    
    // get builds for train
    // "providers/#{team_id}/apps/#{app_id}/platforms/#{platform}/trains/#{train_version}/builds"
    case builds(serviceKey: OlympusServiceKeyInfo, version: Version, appID: AppIdentifier, teamID: TeamIdentifier, platform: Platform)
    
    // get build
    // "providers/#{team_id}/apps/#{app_id}/builds/#{build_id}"
    case build(serviceKey: OlympusServiceKeyInfo, appID: AppIdentifier, teamID: TeamIdentifier, buildID: BuildIdentifier)
    
    // get test info
    // "providers/#{team_id}/apps/#{app_id}/testInfo"
    case appTestInfo(serviceKey: OlympusServiceKeyInfo, appID: AppIdentifier, teamID: TeamIdentifier)
    
    case updateAppTestInfo(serviceKey: OlympusServiceKeyInfo, info: AppTestInfo, appID: AppIdentifier, teamID: TeamIdentifier)
    
    case updateBuildTestInfo(serviceKey: OlympusServiceKeyInfo, info: BuildTestInfo, appID: AppIdentifier, teamID: TeamIdentifier)
    

    var route: URL.Route {
      
      switch self {
        
        case .groups( _, let appID, let teamID):
          // "https://itunesconnect.apple.com/testflight/v2/providers/\(teamID)/apps/\(appID)/groups"
          return URL.Route(path: ["providers",teamID,"apps",appID,"groups"])
        
        // "https://itunesconnect.apple.com/testflight/v2/providers/\(teamID)/apps/\(appID)/testers"
        case .testers( _, let appID, let teamID):
          return URL.Route(path: ["providers",teamID,"apps",appID,"testers"])
        
        // providers/\(teamID)/apps/\(appID)/testers"
        case  .addTesterToApp(_, _, let appID, let teamID):
          let route = URL.Route(path: ["providers",teamID,"apps",appID,"testers"])
          return route
        
        // providers/\(teamID)/apps/\(appID)/groups/\(groupID)/testers
        case .addTesterToTestGroup(_, _, let groupID, let appID, let teamID):
          // providers/\(teamID)/apps/\(appID)/testers"
          let route = URL.Route(path: ["providers",teamID,"apps",appID,"groups",groupID,"testers"])
          return route
        
        // providers/#{team_id}/apps/#{app_id}/platforms/#{platform}/trains
        case .versions(_, let appID, let teamID, let platform):
          let route = URL.Route(path: ["providers",teamID,"apps",appID,"platforms",platform,"trains"])
          return route
        
        // "providers/#{team_id}/apps/#{app_id}/platforms/#{platform}/trains/#{train_version}/builds"
        case .builds(_, let version, let appID, let teamID, let platform):
          let route = URL.Route(path: ["providers",teamID,"apps",appID,"platforms",platform,"trains",version,"builds"])
          return route
        
        // "providers/#{team_id}/apps/#{app_id}/builds/#{build_id}"
        case .build(_, let appID, let teamID, let buildID):
          let route = URL.Route(path: ["providers",teamID,"apps",appID,"builds",buildID])
          return route
        
        // "providers/#{team_id}/apps/#{app_id}/testInfo"
        case .appTestInfo(_, let appID, let teamID):
          let route = URL.Route(path: ["providers", teamID, "apps", appID, "testInfo"])
          return route
        
        // "providers/#{team_id}/apps/#{app_id}/testInfo"
        case .updateAppTestInfo(_, _, let appID, let teamID):
          let route = URL.Route(path: ["providers", teamID, "apps", appID, "testInfo"])
          return route
        
        // providers/#{team_id}/apps/#{app_id}/builds/#{build_id}
        case .updateBuildTestInfo(_, let info, let appID, let teamID):
          let route = URL.Route(path: ["providers",teamID,"apps",appID,"builds",info.id])
          return route
      }
    }
    
    var method: URL.Method {
      switch self {
        case .groups, .testers, .versions, .builds, .build, .appTestInfo:
          return .get
        case .updateAppTestInfo, .updateBuildTestInfo:
          return .put
        case .addTesterToApp, .addTesterToTestGroup:
          return .post
      }
    }
    
    var headers: [HTTPHeader] {
      switch self {
        case .groups(let serviceKey, _, _),
             .testers(let serviceKey, _, _),
             .addTesterToApp(let serviceKey, _, _, _),
             .addTesterToTestGroup(let serviceKey, _, _, _, _),
             .versions(let serviceKey, _, _, _),
             .builds(let serviceKey, _, _, _, _),
             .build(let serviceKey, _, _, _),
             .appTestInfo(let serviceKey, _, _),
             .updateAppTestInfo(let serviceKey, _, _, _),
             .updateBuildTestInfo(let serviceKey, _, _, _):
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
      case .groups,.testers, .versions, .builds, .build, .appTestInfo:
        return nil
      case .addTesterToApp(_, let tester, _, _):
        return try? JSONEncoder().encode(tester)
      case .addTesterToTestGroup(_, let tester, _, _, _):
        return try? JSONEncoder().encode([tester])
      case .updateAppTestInfo(_, let info, _, _):
        return try? JSONEncoder().encode(info)
      case .updateBuildTestInfo(_, let info, _, _):
        return try? JSONEncoder().encode(info)
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
      case .versions:
        return "{\"status\": \"success\"}".data(using: String.Encoding.utf8)!
      case .builds:
        return "{\"status\": \"success\"}".data(using: String.Encoding.utf8)!
      case .build:
        return "{\"status\": \"success\"}".data(using: String.Encoding.utf8)!
      case .appTestInfo:
        return "{\"status\": \"success\"}".data(using: String.Encoding.utf8)!
      case .updateAppTestInfo:
        return "{\"status\": \"success\"}".data(using: String.Encoding.utf8)!
      case .updateBuildTestInfo:
        return "{\"status\": \"success\"}".data(using: String.Encoding.utf8)!
      }
    }
    
  }

  static let current = URL.Env(.https, "itunesconnect.apple.com").at("testflight","v2")

}

