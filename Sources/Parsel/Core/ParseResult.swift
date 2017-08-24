//
//  ParseResult.swift
//  Parsel
//
//  Created by Benjamin Herzog on 13.08.17.
//

public protocol ParseError: Swift.Error { }

/// The result of a parse process.
public enum ParseResult<Token, Result> where Token: Sequence {
    
    /// Parse was successful.
    /// Contains the result and the rest of the token sequence that is unprocessed
    case success(result: Result, rest: Token)
    
    /// Parse was not successful.
    /// Contains the ParseError
    case fail(ParseError)
    
    /// Transforms the result with f, if successful.
    ///
    /// - Parameter transform: a function to use to transform result
    /// - Returns: ParseResult with transformed result or fail with unchanged error.
    public func map<B>(_ transform: (Result, Token) -> B) -> ParseResult<Token, B> {
        switch self {
        case let .success(result, rest):
            return .success(result: transform(result, rest), rest: rest)
        case let .fail(err):
            return .fail(err)
        }
    }
    
    /// Transforms the error if the result is in failed state
    ///
    /// - Parameter transform: a function that takes the wrapped error and returns a new one
    /// - Returns: the result with transformed error or unchanged if successful
    public func mapError(_ transform: (ParseError) -> ParseError) -> ParseResult<Token, Result> {
        guard case let .fail(err) = self else {
            return self
        }
        return .fail(transform(err))
    }
    
    /// Create a new ParseResult for the result.
    ///
    /// - Parameter transform: a function that takes a result and returns a parse result
    /// - Returns: the value that was produced by f if self was success or still fail if not
    public func flatMap<B>(_ transform: (Result, Token) -> ParseResult<Token, B>) -> ParseResult<Token, B> {
        switch self {
        case let .success(result, rest):
            return transform(result, rest)
        case let .fail(err):
            return .fail(err)
        }
    }
    
    /// Checks whether or not the result is successful
    ///
    /// - Returns: true if successful
    public func isSuccess() -> Bool {
        guard case .success = self else {
            return false
        }
        return true
    }
    
    /// Checks whether or not the result is failed
    ///
    /// - Returns: true if failed
    public func isFailed() -> Bool {
        guard case .fail = self else {
            return false
        }
        return true
    }
    
    /// Unwraps the result from the success case.
    ///
    /// - Returns: the result if success
    /// - Throws: Errors.unwrappedFailedResult if not successful
    public func unwrap() throws -> Result {
        switch self {
        case let .success(result, _):
            return result
        default:
            throw Errors.unwrappedFailedResult
        }
    }
    
    /// Unwraps the wrapped result and uses fallback if .fail
    ///
    /// - Parameter fallback: the fallback value to use if parse failed
    /// - Returns: either the parse result or fallback
    public func unwrap(fallback: @autoclosure () -> Result) -> Result {
        return (try? unwrap()) ?? fallback()
    }
    
    /// Returns the rest of the parsing operation in success case.
    ///
    /// - Returns: the rest if successful
    /// - Throws: Errors.unwrappedFailedResult if not successful
    public func rest() throws -> Token {
        switch self {
        case let .success(_, rest):
            return rest
        default:
            throw Errors.unwrappedFailedResult
        }
    }
    
    /// Unwraps the error if not successful
    ///
    /// - Returns: the parsing error if not successful
    /// - Throws: Errors.errorFromSuccessfulResult if successful
    public func error() throws -> ParseError {
        switch self {
        case let .fail(err):
            return err
        default:
            throw Errors.errorFromSuccessfulResult
        }
    }
    
}

/// Compares two ParseResults for equality
/// *NOTE*: two failed ParseResults are always equal!
///
/// Hack until extensions with protocol conformance with constraints are possible
///
/// - Parameters:
///   - lhs: first argument
///   - rhs: second argument
/// - Returns: true if both are equal
public func ==<T, R>(lhs: ParseResult<T, R>, rhs: ParseResult<T, R>) -> Bool where T: Equatable, R: Equatable {
    switch (lhs, rhs) {
    case let (.success(res1, rest1), .success(res2, rest2)):
        return res1 == res2 && rest1 == rest2
    case (.fail, .fail):
        return true
    default:
        return false
    }
}

/// Convenience operator overload to use fallback on fail.
///
/// - Parameters:
///   - lhs: the parse result that could fail
///   - rhs: the fallback that should be used in that case
/// - Returns: either the unwrapped result or fallback
public func ??<T, R>(lhs: ParseResult<T, R>, rhs: @autoclosure () -> R) -> R {
    return lhs.unwrap(fallback: rhs())
}
