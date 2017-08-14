//
//  Operators+Sequential.swift
//  ParsersPackageDescription
//
//  Created by Benjamin Herzog on 14.08.17.
//

import Foundation

public func ~<T, A, B>(lhs: Parser<T, A>, rhs: Parser<T, B>) -> Parser<T, (A, B)> {
    return Parser { tokens in
        switch lhs.parse(tokens) {
        case let .success(result, rest):
            return rhs.parse(rest).map(f: { (result, $0) })
        case let .fail(err):
            return .fail(err)
        }
    }
}

public func ~<T, A, B, C>(lhs: Parser<T, (A, B)>, rhs: Parser<T, C>) -> Parser<T, (A, B, C)> {
    return Parser { tokens in
        switch lhs.parse(tokens) {
        case let .success((resultA, resultB), rest):
            return rhs.parse(rest).map(f: { (resultA, resultB, $0) })
        case let .fail(err):
            return .fail(err)
        }
    }
}

public func ~<T, A, B, C, D>(lhs: Parser<T, (A, B, C)>, rhs: Parser<T, D>) -> Parser<T, (A, B, C, D)> {
    return Parser { tokens in
        switch lhs.parse(tokens) {
        case let .success((resultA, resultB, resultC), rest):
            return rhs.parse(rest).map(f: { (resultA, resultB, resultC, $0) })
        case let .fail(err):
            return .fail(err)
        }
    }
}
