//
//  Host.swift
//  SweetRouter
//
//  Created by Oleksii on 17/03/2017.
//  Copyright © 2017 ViolentOctopus. All rights reserved.
//

import Foundation

public protocol HostType {
    var hostString: String { get }
}

extension String: HostType {
    public var hostString: String {
        return self
    }
}
