//
//  Path.swift
//  SweetRouter
//
//  Created by Oleksii on 16/03/2017.
//  Copyright © 2017 ViolentOctopus. All rights reserved.
//

import Foundation

public protocol RoutePathComponent {
    var stringValue: String { get }
    var pathValue: String { get }
}

public extension RoutePathComponent {
    public var pathValue: String {
        let string = stringValue
        return string.isEmpty ? "" : URL.Path.separator + stringValue
    }
}

public extension URL {
    public struct Path {
        fileprivate static let separator = "/"
        fileprivate let path: [RoutePathComponent]
        
        public init(_ path: RoutePathComponent...) {
            self.init(path)
        }
        
        public init(_ path: [RoutePathComponent]) {
            self.path = path
        }
        
        public func with(_ path: RoutePathComponent...) -> Path {
            return Path(self.path + path)
        }
    }

}

extension URL.Path: RoutePathComponent {
    public var stringValue: String {
        return path.map({ $0.stringValue }).joined(separator: URL.Path.separator)
    }
}

extension URL.Path: Equatable {
    public static func == (lhs: URL.Path, rhs: URL.Path) -> Bool {
        return lhs.path.lazy.map({ $0.stringValue }) == rhs.path.lazy.map({ $0.stringValue })
    }
}

extension URL.Path: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: RoutePathComponent...) {
        self.init(elements)
    }
}

public extension URL.Path {
    public static func + (lhs: URL.Path, rhs: URL.Path) -> URL.Path {
        return URL.Path(lhs.path + rhs.path)
    }
}

extension String: RoutePathComponent {
    public var stringValue: String {
        return self
    }
}

extension Int: RoutePathComponent {
  public var stringValue: String {
    return self.description
  }
}

extension Int64: RoutePathComponent {
  public var stringValue: String {
    return self.description
  }
}
