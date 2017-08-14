//
//  Operators.swift
//  ParserCombinator
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

infix operator ~: ParserConjunctionGroup
infix operator >~: ParserConjunctionGroup
infix operator <~: ParserConjuctionRightGroup

infix operator ^^: ParserMapPrecedenceGroup

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
    return lhs.map(f: rhs)
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


