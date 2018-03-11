//
//  IPv6.swift
//  SweetRouter
//
//  Created by Oleksii on 21/04/2017.
//  Copyright © 2017 ViolentOctopus. All rights reserved.
//

import Foundation

extension IP {
    public struct V6: IPType {
        public let quartets: (UInt16, UInt16, UInt16, UInt16, UInt16, UInt16, UInt16, UInt16)
        
        public init(_ one: UInt16, _ two: UInt16, _ three: UInt16, _ four: UInt16, _ five: UInt16, _ six: UInt16, _ seven: UInt16, _ eight: UInt16) {
            quartets = (one, two, three, four, five, six, seven, eight)
        }
        
        public init?(_ string: String) {
            let numberOfQuarters = 8
            var components = string.components(separatedBy: "::")
            guard components.count <= 2 else { return nil }
            
            if components.count == 2 {
                for item in components.enumerated() where item.element.isEmpty {
                    components[item.offset] = "0"
                }
            }
            let intComponents = components.lazy.map({ $0.components(separatedBy: ":").map({ UInt16($0, radix: 16) }) })
            let intComponentsCount = intComponents.reduce(0, { $0 + $1.count })
            guard intComponentsCount <= numberOfQuarters else { return nil }
            let flattenedComponents = intComponents.map({ $0.flatMap({ $0 }) })
            guard flattenedComponents.reduce(0, { $0 + $1.count }) == intComponentsCount else { return nil }
            var result: [UInt16] = Array(repeating: 0, count: numberOfQuarters)
            func updateValues(from array: [UInt16], start: Int) {
                array.enumerated().forEach({ result[start + $0.offset] = $0.element })
            }
            updateValues(from: flattenedComponents[0], start: 0)
            if let last = flattenedComponents.last {
                updateValues(from: last, start: numberOfQuarters - last.count)
            }
            self.init(result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7])
        }
        
        public var stringValue: String {
            let array = [quartets.0, quartets.1, quartets.2, quartets.3, quartets.4, quartets.5, quartets.6, quartets.7]
            var results = [String]()
            var shortCutRange: (start: Int?, end: Int?) = (nil, nil)
            
            for (i, item) in array.enumerated() {
                let previous = i == array.startIndex ? nil : array[i-1]
                let next = i == array.endIndex - 1 ? nil : array[i+1]
                
                switch (shortCutRange, item, previous, next) {
                case let ((start, nil), 0, .some(0), .some(0)) where start != nil:
                    continue
                case let ((nil, nil), 0, previous, .some(0)) where previous != 0:
                    shortCutRange = (i, nil)
                case let ((start, nil), 0, .some(0), next) where start != nil && next != 0:
                    shortCutRange = (shortCutRange.start, i)
                    results.append("")
                default:
                    results.append(String(item, radix: 16, uppercase: false))
                }
            }
            
            var separator = ":"
            
            if results.count < 3, let index = results.index(of: "") {
                results[index] = "::"
                separator = ""
            }
            
            return results.joined(separator: separator)
        }
    }
}

extension IP.V6: HostType {
    public var hostString: String {
        return "[\(stringValue)]"
    }
}

extension IP.V6: Hashable {
    public static func == (lhs: IP.V6, rhs: IP.V6) -> Bool {
        return lhs.quartets.0 == rhs.quartets.0
            && lhs.quartets.1 == rhs.quartets.1
            && lhs.quartets.2 == rhs.quartets.2
            && lhs.quartets.3 == rhs.quartets.3
            && lhs.quartets.4 == rhs.quartets.4
            && lhs.quartets.5 == rhs.quartets.5
            && lhs.quartets.6 == rhs.quartets.6
            && lhs.quartets.7 == rhs.quartets.7
    }
    
    public var hashValue: Int {
        var hash = 5381
        func newHash(with value: UInt16) {
            hash = ((hash << 5) &+ hash) &+ value.hashValue
        }
        
        newHash(with: quartets.0)
        newHash(with: quartets.1)
        newHash(with: quartets.2)
        newHash(with: quartets.3)
        newHash(with: quartets.4)
        newHash(with: quartets.5)
        newHash(with: quartets.6)
        newHash(with: quartets.7)
        
        return hash
    }
}
