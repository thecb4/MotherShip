//
//  Scheme.swift
//  SweetRouter
//
//  Created by Oleksii on 16/03/2017.
//  Copyright © 2017 ViolentOctopus. All rights reserved.
//

import Foundation

public struct Scheme: RawRepresentable {
    public let rawValue: String
    
    public init(_ rawValue: String) {
        self.init(rawValue: rawValue)
    }
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public extension Scheme {
    public static let http  = Scheme("http")
    public static let https = Scheme("https")
    public static let ws    = Scheme("ws")
    public static let wss   = Scheme("wss")
}

extension Scheme: Hashable {
    public var hashValue: Int {
        return rawValue.hashValue
    }
    
    public static func == (lhs: Scheme, rhs: Scheme) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
