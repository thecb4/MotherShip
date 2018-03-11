//
//  Developer.swift
//  MothershipPackageDescription
//
//  Created by Cavelle Benjamin on 17-Dec-26 (53).
//

import Foundation
import HyperSpace

/*
 "user" : {
 "emailAddress" : "some@email.com",
 "prsId" : "123456677",
 "fullName" : "A C"
 }
*/

struct Developer: Codable {
  
  let emailAddress: String
  let prsId: String
  let fullName: String
  
  init(emailAddress:String = "", fullName:String = "", prsId:String = "") {
    self.emailAddress  = emailAddress
    self.fullName = fullName
    self.prsId = prsId
  }

}

/*
 "availableProviders" : [
  {
    "providerId" : 1234345,
    "name" : "Hello World",
    "contentTypes" : [
      "SOFTWARE"
    ]
  }
 ]
 */

/// Team (Provider) Identifier
public typealias TeamIdentifier  = Int64

/// App Identifier
public typealias AppIdentifier   = Int64

/// Build Identifier
public typealias BuildIdentifier = Int64

/// Build Number
public typealias BuildNumber     = String

extension Int64 {
  init(_ value:Int) {
    self.init(exactly: value)!
  }
}


struct Team: Codable {
  let name: String
  let teamId: TeamIdentifier
  
  init(name:String = "", teamId: TeamIdentifier = 0) {
    self.name = name
    self.teamId = teamId
  }
  
  enum CodingKeys : String, CodingKey {
    case name
    case teamId = "providerId"
  }
  
}

struct DeveloperSession: Codable {
  
  let developer: Developer
  let teams:[Team]
  
  init(developer:Developer = Developer(), teams:[Team] = []) {
    self.developer  = developer
    self.teams = teams
  }
  
  enum CodingKeys : String, CodingKey {
    case developer = "user"
    case teams     = "availableProviders"
  }
  
}
