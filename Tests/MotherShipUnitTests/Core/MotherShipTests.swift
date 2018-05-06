import XCTest
import HyperSpace
@testable import MotherShip

struct AppInfo: Codable {
  let appIdentifier: AppIdentifier
  let teamIdentifier: TeamIdentifier
  let version: Version
  let build: BuildNumber
  let platform: Platform
}

struct TesterInfo: Codable {
  let email: String
  let firstName: String
  let lastName: String
}

class MotherShipTests: XCTestCase {

  let mothership = MotherShip()
  let testFlight = TestFlight()

  static let infoPath = "~/Development/apps/MothershipSolution/MotherShip/.private/"

  override func setUp() {

    print("logging in")

    guard  let creds = MotherShipTests.credentials else {
      XCTAssertNil(nil, "cannot read credentials file")
      return
    }

    do {
      try testFlight.login(with: creds)
    } catch  {
      XCTAssert(true, "login failed")
    }

  }

  private static func json<T: Codable>(from file:String) -> T? {

    let relativePath = infoPath + file

    let fullPath = NSString(string: relativePath).expandingTildeInPath

    guard let string = try? String(contentsOfFile: fullPath, encoding: .utf8) else {
      XCTAssertNotNil(nil, "could not read contents of file \(file)")
      return nil
    }

    guard let data = string.data(using: .utf8) else {
      XCTAssertNotNil(nil, "cannot convert contents of file '\(file)' to utf8 data")
      return nil
    }

    guard let json = try? JSONDecoder().decode(T.self, from: data) else {
      XCTAssertNotNil(nil, "can't decode json from file '\(file)'")
      return nil
    }

    return json

  }

  private static var credentials: LoginCredentials? {

    guard let info: LoginCredentials = json(from: "credentials.json") else {
      XCTAssertNotNil(nil, "could not create credentials")
      return nil
    }

    print(info)

    return info

  }

  private static var appInfo: AppInfo? {

    guard let info: AppInfo = json(from: "app.json") else {
      XCTAssertNotNil(nil, "could not create app info")
      return nil
    }

    print(info)

    return info

  }

  private static var testerInfo: TesterInfo? {

    guard let info: TesterInfo = json(from: "tester.json") else {
      XCTAssertNotNil(nil, "could not create tester info")
      return nil
    }

    print(info)

    return info

  }

  private static var testInfo: AppTestInfo? {

    guard let info: AppTestInfo = json(from: "testInfo.json") else {
      XCTAssertNotNil(nil, "could not create test info")
      return nil
    }

    print(info)

    return info
  }

  private static var buildInfo: BuildTestInfo? {
    guard let info: BuildTestInfo = json(from: "build.json") else {
      XCTAssertNotNil(nil, "could not create build info")
      return nil
    }

    print(info)

    return info
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

    do {

      // given
      let serviceKeyResolve = olympusServiceKeyEndPoint.resolve()

      // when
      let olympusServiceKeyInfo: OlympusServiceKeyInfo = try serviceKeyResolve.json().dematerialize()

      // then
      XCTAssertNotEqual(olympusServiceKeyInfo.authServiceKey, nil)

      // -----

      // given
      let authResolve = Router<IDMSEndPoint>(at: .signIn(credentials: creds, serviceKey: olympusServiceKeyInfo)).resolve()

      // when
      let authInfo: AuthenticationInfo = try authResolve.json().dematerialize()

      // then
      XCTAssertNotEqual(authInfo.authType, nil)

      // -----

      // given
      let sessionResolve = olympusSessionEndPoint.resolve()

      // when
      let sessionInfo: DeveloperSession = try sessionResolve.json().dematerialize()

      // then
      XCTAssertNotEqual(sessionInfo.developer.prsId, nil)

    } catch {

      // finally
      XCTAssert(true, error.localizedDescription)

    }

  }

  func testTestFlightGroups() {

    guard let appInfo = MotherShipTests.appInfo else {
      XCTAssertNil(nil, "cannot read app info file")
      return
    }

    let groups = testFlight.groups(for: appInfo.appIdentifier, in: appInfo.teamIdentifier)

    let defaultExternalGroup = groups.filter {$0.isDefaultExternalGroup == true }

    print(defaultExternalGroup)

    XCTAssertNotNil(defaultExternalGroup)

  }

  func testTestFlightTesters() {

    guard let appInfo = MotherShipTests.appInfo else {
      XCTAssertNil(nil, "cannot read app info file")
      return
    }

    let testers = testFlight.testers(for: appInfo.appIdentifier, in: appInfo.teamIdentifier)

    print(testers)

    XCTAssertNotEqual(testers.count, 0)

  }

//  func testInviteTesterToTestFlight() {
//
//    guard let appInfo = MotherShipTests.appInfo else {
//      XCTAssertNil(nil, "cannot read app info file")
//      return
//    }
//
//    guard let testerInfo = MotherShipTests.testerInfo else {
//      XCTAssertNil(nil, "cannot read tester info file")
//      return
//    }
//
//    let tester = Tester(email: testerInfo.email, firstName: testerInfo.firstName, lastName: testerInfo.lastName)
//
//    let code = testFlight.invite(tester: tester, to: appInfo.appIdentifier, for: appInfo.teamIdentifier)
//
//    XCTAssertEqual(code,HTTPStatusCode.ok, "tester not added to default group")
//
//  }

  func testTestFlightVersions() {

    guard let appInfo = MotherShipTests.appInfo else {
      XCTAssertNil(nil, "cannot read app info file")
      return
    }

    let trains = testFlight.versions(for: appInfo.appIdentifier, in: appInfo.teamIdentifier, on: .ios)

    print(trains)

    XCTAssertEqual(trains.count,1, "did not return correct number of versions")

  }

  func testBuildsForVersion() {

    guard let appInfo = MotherShipTests.appInfo else {
      XCTAssertNil(nil, "cannot read app info file")
      return
    }

    let builds = testFlight.builds(of: appInfo.version, for: appInfo.appIdentifier, in: appInfo.teamIdentifier, on: .ios)

    print(builds)

    XCTAssertEqual(builds.count,1, "did not return correct number of builds for version")

  }

  func testAppTestInfo() {

    guard let appInfo = MotherShipTests.appInfo else {
      XCTAssertNil(nil, "cannot read app info file")
      return
    }

    guard let info = testFlight.testInfo(for: appInfo.appIdentifier, in: appInfo.teamIdentifier) else {
      XCTAssert(true,"app test info not available")
      return
    }

    print(info)

    XCTAssertEqual(info.details.count,1, "did not return correct number of builds for version")

//    let encoder = JSONEncoder()
//    let data = try! encoder.encode(info)
//    print(String(data: data, encoding: .utf8)!)

  }

  func testUpdateAppTestInfo() {

    guard let appInfo = MotherShipTests.appInfo else {
      XCTAssertNil(nil, "cannot read app info file")
      return
    }

    guard let testInfo = MotherShipTests.testInfo else {
      XCTAssertNil(nil, "cannot read test info file")
      return
    }

    let status = testFlight.updateAppTestInfo(with: testInfo, for: appInfo.appIdentifier, in: appInfo.teamIdentifier)

    XCTAssertEqual(status,HTTPStatusCode.ok, "test info not updated")

  }

  func testUpdateBuildTestInfo() {

    guard let appInfo = MotherShipTests.appInfo else {
      XCTAssertNil(nil, "cannot read app info file")
      return
    }

    guard var buildInfo = MotherShipTests.buildInfo else {
      XCTAssertNil(nil, "cannot read test info file")
      return
    }

    #if os(Linux)
      srandom(UInt32(time(nil)))
      randomString = String(format: "%04d", UInt32(random() % 10000))
    #else
      randomString = String(format: "%04d", Int(arc4random_uniform(9999)))
    #endif

    buildInfo.testInfo[0].whatsNew = "test feature number \(randomString)"

    let status = testFlight.updateBuildTestInfo(with: buildInfo, for: appInfo.appIdentifier, in: appInfo.teamIdentifier)

    XCTAssertEqual(status,HTTPStatusCode.ok, "test info not updated")

  }

  func testGetBuild() {

    guard let appInfo = MotherShipTests.appInfo else {
      XCTAssertNil(nil, "cannot read app info file")
      return
    }

    guard let build = testFlight.build(
      buildNumber: appInfo.build,
      version: appInfo.version,
      for: appInfo.appIdentifier,
      in: appInfo.teamIdentifier,
      on: appInfo.platform
      ) else {
        XCTAssertNil(nil, "cannot get build with info \(appInfo)")
        return
    }

    XCTAssertEqual(build.buildVersion, appInfo.build, "did not retrieve correct build number")

  }

}
