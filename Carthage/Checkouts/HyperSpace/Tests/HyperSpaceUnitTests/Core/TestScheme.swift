//
//  TestScheme.swift
//  SweetRouter
//
//  Created by Oleksii on 16/03/2017.
//  Copyright © 2017 ViolentOctopus. All rights reserved.
//

import XCTest
import HyperSpace

class TestScheme: XCTestCase {
    
    func testSchemeHashable() {
        XCTAssertEqual(Scheme.https, Scheme("https"))
        XCTAssertNotEqual(Scheme.ws, Scheme("https"))
        XCTAssertEqual(Scheme.wss.hashValue, Scheme("wss").hashValue)
    }
    
}
