//
//  TestRoutePath.swift
//  SweetRouter
//
//  Created by Oleksii on 16/03/2017.
//  Copyright © 2017 ViolentOctopus. All rights reserved.
//

import XCTest
import HyperSpace

class TestRoutePath: XCTestCase {
    
    func testRouterPathEquatable() {
        XCTAssertNotEqual(URL.Path("new", "api", "cards"), URL.Path("new", "api"))
        XCTAssertEqual(URL.Path("new", "api", "cards"), URL.Path("new", "api", "cards"))
    }
    
    func testRouterPathArrayCreation() {
        let path = "/new/api/cards"
        
        XCTAssertEqual(URL.Path("new", "api", "cards").pathValue, path)
        XCTAssertEqual(URL.Path(URL.Path("new", "api"), "cards").pathValue, path)
        XCTAssertEqual((URL.Path("new", "api") + ["cards"]).pathValue, path)
        XCTAssertEqual(URL.Path("new", "api").with("cards").pathValue, path)
        XCTAssertEqual(URL.Path().pathValue, "")
    }
    
}
