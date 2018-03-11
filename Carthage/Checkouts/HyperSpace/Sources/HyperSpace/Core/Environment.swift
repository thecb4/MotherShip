//
//  Environment.swift
//  SweetRouter
//
//  Created by Oleksii on 17/03/2017.
//  Copyright © 2017 ViolentOctopus. All rights reserved.
//

import Foundation

public extension URL {
    public struct Env {
        public let scheme: Scheme
        public let host: HostType
        public let port: Int?
        public var defaultPath: Path = []
        
        public static func localhost(_ scheme: Scheme, _ port: Int? = nil) -> Env {
            return Env(scheme, "localhost", port)
        }
        
        public static func localhost(_ port: Int? = nil) -> Env {
            return localhost(.http, port)
        }
        
        public init(_ scheme: Scheme, _ host: HostType, _ port: Int? = nil) {
            self.scheme = scheme
            self.host = host
            self.port = port
        }
        
        public init(_ host: HostType, _ port: Int? = nil) {
            self.init(.http, host, port)
        }
        
        public func at(_ defaultPath: RoutePathComponent...) -> Env {
            var env = self
            env.defaultPath = Path(defaultPath)
            return env
        }
    }
}

extension URL.Env: Equatable {
    public static func == (lhs: URL.Env, rhs: URL.Env) -> Bool {
        return lhs.scheme == rhs.scheme
            && lhs.host.hostString == rhs.host.hostString
            && lhs.port == rhs.port
    }
}

extension URL.Env: EnvironmentType {
    public var value: URL.Env {
        return self
    }
}
