import XCTest
import HyperSpace
@testable import MotherShip

struct AppInfo: Codable {
  let appIdentifier: Int64
  let teamIdentifier: Int64
}

struct TesterInfo: Codable {
  let email: String
  let firstName: String
  let lastName: String
}

class MotherShipTests: XCTestCase {
//  func testExample() {
//      // This is an example of a functional test case.
//      // Use XCTAssert and related functions to verify your tests produce the correct
//      // results.
//      XCTAssertEqual(Mothership().text, "Hello, World!")
//  }
  
  let mothership = MotherShip()
  let testFlight = TestFlight()
  
  override func setUp() {
    
    print("logging in")
    
    guard  let creds = MotherShipTests.credentials else {
      XCTAssertNil(nil, "cannot read credentials file")
      return
    }
    
    testFlight.login(with: creds)
    
  }
  
  private static var credentials: LoginCredentials? {
    
    let relativePath = "~/Development/apps/MothershipSolution/MotherShip/.private/credentials.json"
    
    let fullPath = NSString(string: relativePath).expandingTildeInPath
    
    guard let credentialsString = try? String(contentsOfFile: fullPath, encoding: .utf8) else {
      XCTAssertNotNil(nil, "bad path for credentials")
      return nil
    }

    guard let data = credentialsString.data(using: .utf8) else {
      XCTAssertNotNil(nil, "can't convert json string to data")
      return nil
    }
    
    guard let credentials = try? JSONDecoder().decode(LoginCredentials.self, from: data) else {
      XCTAssertNotNil(nil, "can't decode json data to swift struct")
      return nil
    }
    
    print(credentials)
    
    return credentials
    
  }
  
  private static var appInfo: AppInfo? {
    
    let relativePath = "~/Development/apps/MothershipSolution/MotherShip/.private/app.json"
    
    let fullPath = NSString(string: relativePath).expandingTildeInPath
    
    guard let credentialsString = try? String(contentsOfFile: fullPath, encoding: .utf8) else {
      XCTAssertNotNil(nil, "bad path for credentials")
      return nil
    }
    
    guard let data = credentialsString.data(using: .utf8) else {
      XCTAssertNotNil(nil, "can't convert json string to data")
      return nil
    }
    
    guard let appInfo = try? JSONDecoder().decode(AppInfo.self, from: data) else {
      XCTAssertNotNil(nil, "can't decode json data to swift struct")
      return nil
    }
    
    print(appInfo)
    
    return appInfo
    
  }
  
  private static var testerInfo: TesterInfo? {
    
    let relativePath = "~/Development/apps/MothershipSolution/MotherShip/.private/tester.json"
    
    let fullPath = NSString(string: relativePath).expandingTildeInPath
    
    guard let testerString = try? String(contentsOfFile: fullPath, encoding: .utf8) else {
      XCTAssertNotNil(nil, "bad path for tester info")
      return nil
    }
    
    guard let data = testerString.data(using: .utf8) else {
      XCTAssertNotNil(nil, "can't convert json string to data")
      return nil
    }
    
    guard let testerInfo = try? JSONDecoder().decode(TesterInfo.self, from: data) else {
      print(testerString)
      print(data.description)
      XCTAssertNotNil(nil, "can't decode json data to swift struct")
      return nil
    }
    
    print(testerInfo)
    
    return testerInfo
    
  }
  
  func testPath() {
    let path = FileManager.default.currentDirectoryPath
    print(path)
    XCTAssertNotNil(path)
  }
  
  func testLoginSteps() {
    
//    HyperSpace.debug = true
    
    let olympusServiceKeyEndPoint = Router<OlympusEndPoint>(at: .serviceKey)
    let olympusSessionEndPoint    = Router<OlympusEndPoint>(at: .session)
    
    guard  let creds = MotherShipTests.credentials else {
      XCTAssertNotNil(nil)
      return
    }
    
    let keyInfo:OlympusServiceKeyInfo  = olympusServiceKeyEndPoint.decodeJSON()!
    
    XCTAssertNotEqual(keyInfo.authServiceKey, nil)
    
    let idmsEndPoint = Router<IDMSEndPoint>(at: .signIn(credentials: creds, serviceKey: keyInfo))
    
    let authInfo: AuthenticationInfo = idmsEndPoint.decodeJSON()!
    
    XCTAssertNotEqual(authInfo.authType, nil)
    
    let sessionInfo: DeveloperSession = olympusSessionEndPoint.decodeJSON()!
    
    XCTAssertNotEqual(sessionInfo.developer.prsId, nil)
    
  }
  
  func testTestFlightGroups() {
    
//    guard  let creds = MotherShipTests.credentials else {
//      XCTAssertNil(nil, "cannot read credentials file")
//      return
//    }
    
    guard let appInfo = MotherShipTests.appInfo else {
      XCTAssertNil(nil, "cannot read app info file")
      return
    }
    
//    let testFlight = TestFlight()
    
//    testFlight.login(with: creds)
    
    let groups = testFlight.groups(for: appInfo.appIdentifier, in: appInfo.teamIdentifier)
    
    let defaultExternalGroup = groups.filter {$0.isDefaultExternalGroup == true }
    
    print(defaultExternalGroup)
    
    XCTAssertNotNil(defaultExternalGroup)
    
  }
  
  func testTestFlightTesters() {
    
//    guard  let creds = MotherShipTests.credentials else {
//      XCTAssertNil(nil, "cannot read credentials file")
//      return
//    }
    
    guard let appInfo = MotherShipTests.appInfo else {
      XCTAssertNil(nil, "cannot read app info file")
      return
    }
    
//    let testFlight = TestFlight()
    
//    testFlight.login(with: creds)
    
    let testers = testFlight.testers(for: appInfo.appIdentifier, in: appInfo.teamIdentifier)
    
    print(testers)

    XCTAssertNotEqual(testers.count, 0)
    
  }

  func testInviteTesterToTestFlight() {
    
//    guard  let creds = MotherShipTests.credentials else {
//      XCTAssertNil(nil, "cannot read credentials file")
//      return
//    }
    
    guard let appInfo = MotherShipTests.appInfo else {
      XCTAssertNil(nil, "cannot read app info file")
      return
    }
    
    guard let testerInfo = MotherShipTests.testerInfo else {
      XCTAssertNil(nil, "cannot read tester info file")
      return
    }
    
    let tester = Tester(email: testerInfo.email, firstName: testerInfo.firstName, lastName: testerInfo.lastName)
    
//    let testFlight = TestFlight()
//
//    testFlight.login(with: creds)
    
    let code = testFlight.invite(tester: tester, to: appInfo.appIdentifier, for: appInfo.teamIdentifier)
    
    XCTAssertEqual(code,200, "tester not added to default group")
    
  }
  
  func testTestFlightVersions() {
    
//    guard  let creds = MotherShipTests.credentials else {
//      XCTAssertNil(nil, "cannot read credentials file")
//      return
//    }
    
    guard let appInfo = MotherShipTests.appInfo else {
      XCTAssertNil(nil, "cannot read app info file")
      return
    }
    
//    let testFlight = TestFlight()
//
//    testFlight.login(with: creds)
    
    let trains = testFlight.versions(for: appInfo.appIdentifier, in: appInfo.teamIdentifier, on: .ios)
    
    print(trains)
    
    XCTAssertEqual(trains.count,1, "did not return correct number of build trains")
    
  }
  
  func testBuildsForVersion() {
    
    guard let appInfo = MotherShipTests.appInfo else {
      XCTAssertNil(nil, "cannot read app info file")
      return
    }
    
//    let builds = testFlight.builds(version: Version)
    
  }
    
}

