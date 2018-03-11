//
//  Query.swift
//  SweetRouter
//
//  Created by Oleksii on 16/03/2017.
//  Copyright © 2017 ViolentOctopus. All rights reserved.
//

import Foundation

public protocol QueryItemValue {
    var stringValue: String { get }
}

public extension URL {
    public struct Query {
        fileprivate let items: [(name: String, value: QueryItemValue?)]
        
        public init(_ items: (name: String, value: QueryItemValue?)...) {
            self.init(items)
        }
        
        public init(_ items: [(name: String, value: QueryItemValue?)]) {
            self.items = items
        }
        
        public var queryItems: [URLQueryItem] {
            return items.map({ URLQueryItem(name: $0.name, value: $0.value?.stringValue) })
        }
    }
}

extension URL.Query: Equatable {
    public static func == (lhs: URL.Query, rhs: URL.Query) -> Bool {
        let lhs = lhs.items, rhs = rhs.items
        guard lhs.count == rhs.count else { return false }
        
        for i in 0..<lhs.count {
            let left = lhs[i], right = rhs[i]
            if left.name != right.name || left.value?.stringValue != right.value?.stringValue {
                return false
            }
        }
        
        return true
    }
}

extension String: QueryItemValue {}
