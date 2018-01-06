//
//  TestFlight.json.swift
//  Mothership
//
//  Created by Cavelle Benjamin on 17-Dec-26 (53).
//

import Foundation

public struct Tester: Codable {
  
  let id: String
  let email: String
  let firstName: String
  let lastName: String
  let groups: [String]
  let latestInstallInfo: InstallInfo?
  let latestInstalledTrain: String?
  let latestInstalledVersion: String?
  let installCount: Int?
  let sessionCount: Int?
  let crashCount: Int?
  
  init(
    id: String = "",
    email:String = "",
    firstName: String = "",
    lastName: String = "",
    groups: [String] = [],
    latestInstallInfo: InstallInfo? = nil,
    latestInstalledTrain: String? = nil,
    latestInstalledVersion: String? = nil,
    installCount: Int? = nil,
    sessionCount: Int? = nil,
    crashCount: Int? = nil
    ) {
    self.id = id
    self.email = email
    self.firstName = firstName
    self.lastName = lastName
    self.groups = groups
    self.latestInstallInfo = latestInstallInfo
    self.latestInstalledTrain = latestInstalledTrain
    self.latestInstalledVersion = latestInstalledVersion
    self.installCount = installCount
    self.sessionCount = sessionCount
    self.crashCount = crashCount
  }
  
}

extension Tester: CustomStringConvertible {
  public var description: String {
    get {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      if let json = try? encoder.encode(self) {
        if let string = String(data: json, encoding: .utf8) {
          return string
        }
      }
      return "Cannot Describe \(self)"
    }
  }
}

struct InstallInfo: Codable {
  let latestInstalledAppAdamId: String?
  let latestInstalledBuildId: String?
  let latestInstalledDate: String?
  let latestInstalledShortVersion: String?
  let latestInstalledVersion: String?
}

struct Testers: Codable {
  let data: [Tester]
  
  init(with data:[Tester] = []) {
    self.data = data
  }
  
}

/*
 "id" : "",
 "providerId" : ,
 "appAdamId" : ,
 "name" : "ITC.apps.tf.labels.internalTesters",
 "created" : "2017-12-21T21:42:38.743+0000",
 "active" : true,
 "isInternalGroup" : true,
 "isDefaultExternalGroup" : false
 */

struct Group: Codable {
  let id: String
  let teamID: TeamIdentifier
  let appID:  AppIdentifier
  let name: String
  let active: Bool
  let isInternalGroup: Bool
  let isDefaultExternalGroup: Bool
  
  public init(
    id: String = "",
    teamID: TeamIdentifier = TeamIdentifier(exactly: 0)!,
    appID:  AppIdentifier = AppIdentifier(exactly: 0)!,
    name: String = "",
    active: Bool = false,
    isInternalGroup: Bool = false,
    isDefaultExternalGroup: Bool = false
  ) {
    self.id     = id
    self.teamID = teamID
    self.appID  = appID
    self.name   = name
    self.active = active
    self.isInternalGroup = isInternalGroup
    self.isDefaultExternalGroup = isDefaultExternalGroup
    
  }
  
  enum CodingKeys : String, CodingKey {
    case id
    case teamID = "providerId"
    case appID  = "appAdamId"
    case name
    case active
    case isInternalGroup
    case isDefaultExternalGroup
  }
  
}

struct Groups: Codable {
  let data: [Group]
  
  init(data: [Group] = [Group]()){
    self.data = data
  }
}
