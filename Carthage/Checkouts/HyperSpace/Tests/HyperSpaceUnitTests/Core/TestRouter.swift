//
//  TestRouter.swift
//  SweetRouter
//
//  Created by Oleksii on 17/03/2017.
//  Copyright © 2017 ViolentOctopus. All rights reserved.
//

import XCTest
import HyperSpace
import Result

struct Api: EndpointType {
  enum Environment: EnvironmentType {
      case localhost
      case test
      case production

      var value: URL.Env {
          switch self {
          case .localhost: return .localhost(8080)
          case .test: return .init(IP(126, 251, 20, 32))
          case .production: return .init(.https, "myproductionserver.com", 3000)
          }
      }
  }

  enum Route: RouteType {

    case auth, me
    case posts(for: String)

    var route: URL.Route {
        switch self {
        case .me: return URL.Route(at: "me").fragment("test")
        case .auth: return .init(at: "auth")
        case let .posts(for: date):
            return URL.Route(at: "posts").query(("date", date), ("userId", "someId"))
        }
    }

    var method: URL.Method {
      switch self {
      case .me, .auth:
        return .get
      case .posts:
        return .post
      }
    }

    var headers: [HTTPHeader] {
      switch self {
      case .auth, .me, .posts:
        return []
      }
    }

    var body: Data? {
      switch self {
      case .auth, .me, .posts:
        return nil
      }
    }

    var mockResponseData: Data {
      switch self {
      case .auth:
        return "{\"status\": \"success\"}".data(using: String.Encoding.utf8)!
      case .me:
        return "{\"status\": \"failure\"}".data(using: String.Encoding.utf8)!
      case .posts:
        return "{ \"data\": [ {\"first\":\"good\"},{\"second\":\"bad\"} ] }".data(using: String.Encoding.utf8)!
      }
    }

  }

  static let current: Environment = .localhost

}

struct Auth: EndpointType {
  enum Route: RouteType {
    case signIn, signOut

    var route: URL.Route {
      switch self {
      case .signIn: return .init(at: "signIn")
      case .signOut: return .init(at: "me", "signOut")
      }
    }

    var method: URL.Method {
      switch self {
      case .signIn:
        return .post
      case .signOut:
        return .get
      }
    }

    var headers: [HTTPHeader] {
      switch self {
      case .signIn, .signOut:
        return [
          HTTPHeader(field:"Content-Type",value:"application/json")
        ]
      }
    }

    var body: Data? {
      switch self {
      case .signIn, .signOut:
        let data = try? JSONEncoder().encode(["apple":"sauce"])
        return data
      }
    }

    var mockResponseData: Data {
      switch self {
        case .signIn:
          return "{\"status\": \"success\"}".data(using: String.Encoding.utf8)!
        case .signOut:
          return "{\"status\": \"failure\"}".data(using: String.Encoding.utf8)!
      }
    }


//    var request: URLRequest {
//      switch self {
//      case .signIn:
//        return Request(self)
//      }
//    }

  }

  static let current = URL.Env(.https, "auth.server.com", 8080).at("api", "new")
}

struct SignIn: Codable {
  let status: String
}

struct SignOut: Codable {
  let status: String
}

extension SignIn: Equatable {
  public static func == (lhs: SignIn, rhs: SignIn) -> Bool {
    return lhs.status == rhs.status
  }
}

class TestRouter: XCTestCase {

  func testApiRouter() {

    HyperSpace.debug = true

    XCTAssertEqual(Router<Api>(at: .me).url, URL(string: "http://localhost:8080/me#test"))
    XCTAssertEqual(Router<Api>(.test, at: .auth).url, URL(string: "http://126.251.20.32/auth"))
    XCTAssertEqual(Router<Api>(.production, at: .posts(for: "12.04.2017")).url, URL(string: "https://myproductionserver.com:3000/posts?date=12.04.2017&userId=someId"))

    XCTAssertEqual(Router<Api>(at: .me).request().url,URL(string: "http://localhost:8080/me#test"))

    let request = Router<Api>(at: .me).request(with: .useProtocolCachePolicy, timeoutInterval: 500)
    XCTAssertEqual(request.url,URL(string: "http://localhost:8080/me#test"))
    XCTAssertNil(Router<Api>(at: .me).route.body)

    let result: Result<SignIn, URL.ResponseError> = Router<Api>(.test, at: .auth).resolve().json()
    let expected = SignIn(status: "success")

    switch result {
    case .success( let actual ):
        XCTAssertEqual(actual,expected)
      case .failure( _ ):
        XCTAssertNil(nil)
    }



  }

  func testAuthRouter() {
    XCTAssertEqual(Router<Auth>(at: .signIn).url, URL(string: "https://auth.server.com:8080/api/new/signIn"))
    XCTAssertEqual(Router<Auth>(at: .signOut).url, URL(string: "https://auth.server.com:8080/api/new/me/signOut"))
    XCTAssertEqual(Router<Auth>(at: .signIn).request().url,URL(string: "https://auth.server.com:8080/api/new/signIn"))

    let request = Router<Auth>(at: .signIn).request(with: .useProtocolCachePolicy, timeoutInterval: 500)
    XCTAssertEqual(request.url,URL(string: "https://auth.server.com:8080/api/new/signIn"))
    XCTAssertNotNil(Router<Auth>(at: .signIn).route.body)
  }

}
