//
//  Operators.swift
//  Parsel
//
//  Created by Benjamin Herzog on 13.08.17.
//

// MARK: - Precendence groups and declaration

// Check https://github.com/apple/swift-evolution/blob/master/proposals/0077-operator-precedence.md for reference

/// ^^ and ^^^
precedencegroup ParserMapPrecedenceGroup {
    associativity: left
    lowerThan: AdditionPrecedence, BitwiseShiftPrecedence, NilCoalescingPrecedence, DefaultPrecedence
}

/// ~ and ~>
precedencegroup ParserConjunctionGroup {
    associativity: left
    lowerThan: NilCoalescingPrecedence
    higherThan: ParserMapPrecedenceGroup, DefaultPrecedence
}

/// <~
precedencegroup ParserConjuctionRightGroup {
    associativity: left
    lowerThan: NilCoalescingPrecedence
    higherThan: ParserConjunctionGroup
}

postfix operator +
postfix operator *

infix operator ~: ParserConjunctionGroup
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
    return lhs.atLeastOne
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

/// ~= allows the usage of `Parser`s in switch-case pattern matching statements.
///
/// example:
/// ```Swift
/// switch "a" {
///     case L.char: print("it's a char \o/")
///     case L.digit: print("it's a digit!")
///     default: print("it's something unexpected :/")
/// ```
///
/// **NOTE**: Be aware that this also checks if the rest is empty to ensure the
///           whole input matches!
///
/// - Parameters:
///   - lhs: the pattern, in this case the parser that should succeed
///   - rhs: the value that the pattern should be matched with
/// - Returns: true if the parsing succeeds, false otherwise
public func ~=<T, U>(lhs: Parser<T, U>, rhs: T) -> Bool {
    let res = lhs.parse(rhs)
    guard let rest = try? res.rest() else {
        return false
    }
    return res.isSuccess() && !rest.contains(where: {_ in true})
}
