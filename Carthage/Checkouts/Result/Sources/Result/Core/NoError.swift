//
//  NoError.swift
//  Result
//
//  Created by Cavelle Benjamin on 18-Jan-14 (02).
//

/// An “error” that is impossible to construct.
///
/// This can be used to describe `Result`s where failures will never
/// be generated. For example, `Result<Int, NoError>` describes a result that
/// contains an `Int`eger and is guaranteed never to be a `failure`.
public enum NoError: Swift.Error, Equatable {
  public static func ==(lhs: NoError, rhs: NoError) -> Bool {
    return true
  }
}
