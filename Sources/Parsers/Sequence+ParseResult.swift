//
//  Sequence+ParseResult.swift
//  ParsersPackageDescription
//
//  Created by Benjamin Herzog on 13.08.17.
//

import Foundation

// commented out, since it's not possible 😭
//public extension Sequence where Element == ParseResult<> {

public func onlySuccess<S: Sequence, T, R>(_ seq: S) -> [ParseResult<T, R>] where S.Element == ParseResult<T, R> {
    return seq.filter { $0.isSuccess() }
}

public func onlyFails<S: Sequence, T, R>(_ seq: S) -> [ParseResult<T, R>] where S.Element == ParseResult<T, R> {
    return seq.filter { $0.isFailed()}
}

//}
