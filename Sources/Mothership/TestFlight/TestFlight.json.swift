//
//  TestFlight.json.swift
//  Mothership
//
//  Created by Cavelle Benjamin on 17-Dec-26 (53).
//

import Foundation

public struct Tester: Codable {
  
  public let id: String
  public let email: String
  public let firstName: String
  public let lastName: String
  public let groups: [String]
  public let latestInstallInfo: InstallInfo?
  public let latestInstalledTrain: String?
  public let latestInstalledVersion: String?
  public let installCount: Int?
  public let sessionCount: Int?
  public let crashCount: Int?
  
 public  init(
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

public struct InstallInfo: Codable {
  public let latestInstalledAppAdamId: String?
  public let latestInstalledBuildId: String?
  public let latestInstalledDate: String?
  public let latestInstalledShortVersion: String?
  public let latestInstalledVersion: String?
}

public struct Testers: Codable {
  public let data: [Tester]
  
  public init(with data:[Tester] = []) {
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

public struct Group: Codable {
  public let id: String
  public let teamID: TeamIdentifier
  public let appID:  AppIdentifier
  public let name: String
  public let active: Bool
  public let isInternalGroup: Bool
  public let isDefaultExternalGroup: Bool
  
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

public struct Groups: Codable {
  public let data: [Group]
  
  public init(data: [Group] = [Group]()){
    self.data = data
  }
}
