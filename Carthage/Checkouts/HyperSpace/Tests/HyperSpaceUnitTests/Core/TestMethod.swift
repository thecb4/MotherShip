//
//  TestMethod.swift
//  HyperSpaceTests
//
//  Created by Cavelle Benjamin on 17-Dec-30 (53).
//

import XCTest
import HyperSpace

class TestMethod: XCTestCase {
  
  func testMethodHashable() {
    XCTAssertEqual(URL.Method.get, URL.Method("GET"))
    XCTAssertNotEqual(URL.Method.get, URL.Method("PUT"))
    XCTAssertEqual(URL.Method.get.hashValue, URL.Method("GET").hashValue)
  }
  
}
