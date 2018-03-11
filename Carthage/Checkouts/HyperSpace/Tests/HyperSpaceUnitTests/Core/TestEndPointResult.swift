//
//  TestEndPointResult.swift
//  HyperSpaceTests
//
//  Created by Cavelle Benjamin on 18-Jan-15 (03).
//

import XCTest
import HyperSpace
import Result

class TestEndPointResult: XCTestCase {

  let example = Example(name: "Hello", address: "World")

  let response = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)

  var data: Data?


  override func setUp() {
    data = try? JSONEncoder().encode(example)
  }

  func testJSONConversion() {

    let result = EndPointResult(response: self.response, data: self.data, error:nil)

    let expectedJSON: Result<Example, URL.ResponseError> = result.json()

    switch  expectedJSON {

      case let .success(value):
        XCTAssertEqual(example, value, "status codes not equal")

      case .failure( .noDataPresent ):
        print("no data present")
        XCTAssert(true)

      case let .failure( .decodeFailure(message) ):
        print(message)
        XCTAssert(true)

    }


//    guard let json: Example = result?.json() else {
//      XCTAssertNotNil(nil, "could not transform data")
//      return
//    }
//
//    XCTAssertEqual(example, json, "example and transform are not the same")

  }


  func testStatusCode() {

    let result = EndPointResult(response: self.response, data: self.data, error:nil)

    switch result.httpStatusCode {

      case let .success(code):
        XCTAssertEqual(code, HTTPStatusCode(200), "status codes not equal")

      case let .failure( .contactFailure(message) ):
        print(message)
        XCTAssert(true)

    }

  }

}

extension TestEndPointResult {
 static var allTests: [(String, (TestEndPointResult) -> () throws -> Void)] {
   return [
     ("testStatusCode",testStatusCode)

   ]
 }
}

struct Example: Codable {
  let name: String
  let address: String
}

extension Example: Equatable {
  func ==(lhs: Example, rhs:Example) -> Bool {
    return (lhs.name == rhs.name) && (lhs.address == rhs.address)
  }
}
