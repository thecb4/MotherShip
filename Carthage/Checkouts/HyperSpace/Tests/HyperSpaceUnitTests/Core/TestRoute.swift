//
//  TestRoute.swift
//  SweetRouter
//
//  Created by Oleksii on 17/03/2017.
//  Copyright © 2017 ViolentOctopus. All rights reserved.
//

import XCTest
import HyperSpace

class TestRoute: XCTestCase {
    
    func testUrlRouteEquatable() {
        XCTAssertEqual(URL.Route(at: "myPath").query(("user", nil), ("date", "12.04.02")), URL.Route(path: ["myPath"], query: URL.Query(("user", nil), ("date", "12.04.02"))))
        XCTAssertEqual(URL.Route(at: "myPath").fragment("fragment"), URL.Route(path: ["myPath"], fragment: "fragment"))
        XCTAssertNotEqual(URL.Route(at: "myPath").query(("user", nil)).fragment("fragment"), URL.Route(path: ["myPath"], fragment: "fragment"))
    }
    
}
