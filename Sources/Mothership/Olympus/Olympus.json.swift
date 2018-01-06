//
//  OlympusService.swift
//  MothershipPackageDescription
//
//  Created by Cavelle Benjamin on 17-Dec-25 (53).
//

import Foundation


// typesafe service response
struct OlympusServiceKeyInfo: Codable {
  let authServiceUrl: String
  let authServiceKey: String
  
  init() {
    authServiceUrl = ""
    authServiceKey = ""
  }
}


