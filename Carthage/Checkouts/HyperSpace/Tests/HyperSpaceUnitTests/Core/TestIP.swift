//
//  TestIP.swift
//  SweetRouter
//
//  Created by Oleksii on 16/03/2017.
//  Copyright © 2017 ViolentOctopus. All rights reserved.
//

import XCTest
import HyperSpace

class TestIP: XCTestCase {
    
    func testIPHashable() {
        XCTAssertEqual(IP(127, 0, 0, 1), IP(127, 0, 0, 1))
        XCTAssertEqual(IP(127, 0, 0, 1).hashValue, IP(127, 0, 0, 1).hashValue)
        XCTAssertNotEqual(IP(127, 0, 127, 1).hashValue, IP(0, 1, 0, 2).hashValue)
        XCTAssertNotEqual(IP(127, 24, 127, 25).hashValue, IP(12, 24, 12, 25).hashValue)
    }
    
    func testIPStringInit() {
        XCTAssertEqual(IP("127.24.127.25"), IP(127, 24, 127, 25))
        XCTAssertEqual(IP("0.0.0.0"), IP(0, 0, 0, 0))
        XCTAssertEqual(IP("255.255.255.255"), IP(255, 255, 255, 255))
        XCTAssertNil(IP("255.255.256.255"))
        XCTAssertNil(IP("128.0.256"))
        XCTAssertNil(IP("randomString"))
    }
    
    func testIPv6Hashable() {
        XCTAssertEqual(IP.V6(0x2001,0xcdba,0x0000,0x0000,0x0000,0x0000,0x3257,0x9652), IP.V6(0x2001,0xCDBA,0,0,0,0,0x3257,0x9652))
        XCTAssertEqual(IP.V6(0x2001,0xcdba,0x0,0x0,0x0,0x0,0x3257,0x9652).hashValue, IP.V6(0x2001,0xcdba,0x0,0x0,0x0,0x0,0x3257,0x9652).hashValue)
        XCTAssertNotEqual(IP.V6(0x2001,0xcdba,0,0,0,0,0x3257,0x9652).hashValue, IP.V6(0x2001,0xcdba,0x0,0x3257,0x0,0x3257,0x3257,0x9652).hashValue)
    }
    
    func testIPv6StringInit() {
        XCTAssertEqual(IP.V6("2001:db8:85a3:0:0:8a2e:370:7334"), IP.V6(0x2001,0xdb8,0x85a3,0x0,0x0,0x8a2e,0x370,0x7334))
        XCTAssertEqual(IP.V6("2001:db8:85a3:0:0:8a2e:370::"), IP.V6(0x2001,0xdb8,0x85a3,0,0,0x8a2e,0x370,0))
        XCTAssertEqual(IP.V6("2001:db8:85a3::8a2e:370:7334"), IP.V6(0x2001,0xdb8,0x85a3,0x0,0x0,0x8a2e,0x370,0x7334))
        XCTAssertEqual(IP.V6("::"), IP.V6(0,0,0,0,0,0,0,0))
        XCTAssertEqual(IP.V6("::1"), IP.V6(0,0,0,0,0,0,0,1))
        XCTAssertEqual(IP.V6("1::"), IP.V6(1,0,0,0,0,0,0,0))
        XCTAssertNil(IP.V6(":::"))
        XCTAssertNil(IP.V6("2001:db8:85a3:0:0:0:8a2e:370:7334"))
        XCTAssertNil(IP.V6("zeee::85a3::8a2e:370:7334"))
    }
    
    func testIPv6StringValue() {
        XCTAssertEqual(IP.V6(0x2001,0xdb8,0x85a3,0x0,0x0,0x8a2e,0x370,0x7334).stringValue, "2001:db8:85a3::8a2e:370:7334")
        XCTAssertEqual(IP.V6(0,0,0,0,0,0,0,0).stringValue, "::")
        XCTAssertEqual(IP.V6(0,0,0,0,0,0,0,1).stringValue, "::1")
        XCTAssertEqual(IP.V6(0x2001,0xdb8,0x0,0x0,0x1,0x0,0x0,0x1).stringValue, "2001:db8::1:0:0:1")
        XCTAssertEqual(IP.V6(0x2001,0xdb8,0,0,0x1,0,0,0).stringValue, "2001:db8::1:0:0:0")
        XCTAssertEqual(IP.V6(0x2001,0xdb8,0,0,0,0,0x2,0x1).stringValue, "2001:db8::2:1")
        XCTAssertEqual(IP.V6(0x2001,0xdb8,0,0x1,0x1,0x1,0x1,0x1).stringValue, "2001:db8:0:1:1:1:1:1")
    }
    
}
