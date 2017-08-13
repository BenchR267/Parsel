//
//  Operators.swift
//  ParsersPackageDescription
//
//  Created by Benjamin Herzog on 13.08.17.
//

import Foundation

/// Convenience operator for 'or' conjunction.
///
/// - Parameters:
///   - lhs: the first parser to evaluate
///   - rhs: the second parser to evaluate
/// - Returns: a parser that evaluates both, rhs and lhs, starting with lhs
public func ||<T, R>(lhs: Parser<T, R>, rhs: @escaping @autoclosure () -> Parser<T, R>) -> Parser<T, R> {
    return lhs.or(rhs())
}

/// Convenience operator for 'then' concatenation.
///
/// - Parameters:
///   - lhs: the first parser to evaluate
///   - rhs: the second parser to evaluate on lhs' rest
/// - Returns: a parser that evaluates lhs and on it's rest rhs
public func >><T, R, B>(lhs: Parser<T, R>, rhs: @escaping @autoclosure () -> Parser<T, B>) -> Parser<T, B> {
    return lhs.then(rhs())
}

precedencegroup ParserMapPrecedenceGroup {
    associativity: left
    higherThan: BitwiseShiftPrecedence
}

infix operator ^^: ParserMapPrecedenceGroup

/// Convenience operator for map operations.
///
/// - Parameters:
///   - lhs: a parser to evaluate
///   - rhs: a mapping operation to call on lhs' result
/// - Returns: a parser that calls lhs and transforms its result with rhs afterwards.
public func ^^<T, R, B>(lhs: Parser<T, R>, rhs: @escaping (R) -> B) -> Parser<T, B> {
    return lhs.map(f: rhs)
}
