//
//  TestEnvironment.swift
//  SweetRouter
//
//  Created by Oleksii on 17/03/2017.
//  Copyright © 2017 ViolentOctopus. All rights reserved.
//

import XCTest
import HyperSpace

class TestEnvironment: XCTestCase {
    func testEnvironmentEquatable() {
        XCTAssertEqual(URL.Env(IP(127, 0, 0, 1), 8080), URL.Env(.http, "127.0.0.1", 8080))
        XCTAssertEqual(URL.Env(IP.V6(0x2001,0xdb8,0,0,0x1,0,0,0), 8080), URL.Env(.http, "[2001:db8::1:0:0:0]", 8080))
        XCTAssertEqual(URL.Env.localhost(4001), URL.Env(.http, "localhost", 4001))
    }
    
    func testEnvironmentURLConvertable() {
        XCTAssertEqual(URL.Env(IP(127, 0, 0, 1), 8080).at("api", "new").url, URL(string: "http://127.0.0.1:8080/api/new"))
        XCTAssertEqual(URL.Env(IP.V6(0x2001,0xdb8,0,0,0x1,0,0,0), 8080).url, URL(string: "http://[2001:db8::1:0:0:0]:8080"))
        XCTAssertEqual(URL.Env.localhost(4001).url, URL(string: "http://localhost:4001"))
    }
}
