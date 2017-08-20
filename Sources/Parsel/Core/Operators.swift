//
//  Operators.swift
//  Parsel
//
//  Created by Benjamin Herzog on 13.08.17.
//

// MARK: - Precendence groups and declaration

precedencegroup ParserConjunctionGroup {
    associativity: left
    higherThan: BitwiseShiftPrecedence
}

precedencegroup ParserConjuctionRightGroup {
    associativity: right
    higherThan: ParserConjunctionGroup
}

precedencegroup ParserMapPrecedenceGroup {
    associativity: left
    higherThan: ParserConjunctionGroup
}

postfix operator +
postfix operator *

infix operator ~: ParserConjunctionGroup
infix operator >~: ParserConjunctionGroup
infix operator <~: ParserConjuctionRightGroup

infix operator ^^: ParserMapPrecedenceGroup
infix operator ^^^: ParserMapPrecedenceGroup

// MARK: - Implementation

/// Convenience operator for 'or' conjunction.
///
/// - Parameters:
///   - lhs: the first parser to evaluate
///   - rhs: the second parser to evaluate
/// - Returns: a parser that evaluates both, rhs and lhs, starting with lhs
public func |<T, R>(lhs: Parser<T, R>, rhs: @escaping @autoclosure () -> Parser<T, R>) -> Parser<T, R> {
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

/// Convenience operator for map operations.
///
/// - Parameters:
///   - lhs: a parser to evaluate
///   - rhs: a mapping operation to call on lhs' result
/// - Returns: a parser that calls lhs and transforms its result with rhs afterwards.
public func ^^<T, R, B>(lhs: Parser<T, R>, rhs: @escaping (R) -> B) -> Parser<T, B> {
    return lhs.map(rhs)
}

/// Convenience operator for map operation. Replaces the result of lhs with rhs
/// if lhs succeeded.
///
/// - Parameters:
///   - lhs: the parser which result should be replaced
///   - rhs: the value that should replace the result of lhs
/// - Returns: a parser that parses lhs and replaces its result with rhs if it succeeds
public func ^^^<T, R, B>(lhs: Parser<T, R>, rhs: @escaping @autoclosure () -> B) -> Parser<T, B> {
    return lhs.map({ _ in rhs() })
}

/// Convenience operator for atLeastOnce operation.
///
/// - Parameter lhs: the parser that should succeed at least once.
/// - Returns: a parser that parses lhs repetitive with at least one successful result.
public postfix func +<T, R>(lhs: Parser<T, R>) -> Parser<T, [R]> {
    return lhs.atLeastOnce
}

/// Convenience oeprator for rep operation. (repetitive parsing.
///
/// - Parameter lhs: the parser that should be parses repetitive
/// - Returns: a parser that parses lhs as long as it succeeds
public postfix func *<T, R>(lhs: Parser<T, R>) -> Parser<T, [R]> {
    return lhs.rep
}

/// Convenience operator for fallback operation.
///
/// - Parameters:
///   - lhs: the parser that could possibly fail
///   - rhs: the default value that should be used instead
/// - Returns: a parser that tries to parse self and uses rhs if parsing failed.
public func ??<T, R>(lhs: Parser<T, R>, rhs: @escaping @autoclosure () -> R) -> Parser<T, R> {
    return lhs.fallback(rhs())
}

/// Convenience operator for fallback with parser operation.
///
/// - Parameters:
///   - lhs: the parser that could fail
///   - rhs: the parser that should be used instead
/// - Returns: a parser that tries to parse self and parses rhs if self failed.
public func ??<T, R>(lhs: Parser<T, R>, rhs: @escaping @autoclosure () -> Parser<T, R>) -> Parser<T, R> {
    return lhs.fallback(rhs())
}
