//
//  ISO8601.swift
//  MotherShip
//
//  Created by Cavelle Benjamin on 18-Jan-14 (02).
//

import Foundation

// https://stackoverflow.com/questions/28016578/swift-how-to-create-a-date-time-stamp-and-format-as-iso-8601-rfc-3339-utc-tim

extension Formatter {
  static let iso8601: DateFormatter = {
    let formatter = DateFormatter()
    formatter.calendar = Calendar(identifier: .iso8601)
//    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
    return formatter
  }()
}
extension Date {
  var iso8601: String {
    return Formatter.iso8601.string(from: self)
  }
}

extension String {
  var dateFromISO8601: Date? {
    return Formatter.iso8601.date(from: self)   // "Mar 22, 2017, 10:22 AM"
  }
}
