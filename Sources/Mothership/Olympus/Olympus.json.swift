//
//  OlympusService.swift
//  MothershipPackageDescription
//
//  Created by Cavelle Benjamin on 17-Dec-25 (53).
//

import Foundation
//import Moya
//import Result


// typesafe service response
struct OlympusServiceKeyInfo: Codable {
  let authServiceUrl: String
  let authServiceKey: String
  
  init() {
    authServiceUrl = ""
    authServiceKey = ""
  }
}

//enum OlympusServiceError: Error {
//  case couldNotParse
//}

//typealias OlympusServiceResult = Result<OlympusServiceKeyInfo, OlympusServiceError>
//
//enum OlympusService {
//  case config(hostName: String)
//}


//typealias OlympusProvider = MoyaProvider<OlympusService>


