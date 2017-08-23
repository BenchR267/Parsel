//
//  Errors.swift
//  Parsel
//
//  Created by Benjamin Herzog on 13.08.17.
//

/// Generic errors that could occur on Core parsers
public enum Errors: ParseError {
    
    /// is thrown when `.unwrap()` is called on a failed ParseResult
    case unwrappedFailedResult
    
    /// is thrown when `error()` is called on a succeeded ParseResult
    case errorFromSuccessfulResult
    
    /// is returned when `Parser.or` is called on an empty collection of parsers
    case conjunctionOfEmptyCollection
    
    /// is returned when `atLeastOnce` failed because the parser succeeded not at all
    case expectedAtLeastOnce
    
    /// is returned when `atLeast(count:)` failed because the parser succeeded less than n
    case expectedAtLeast(Int, got: Int)
    
    /// is returned when `exactly(count:)` failed because the parser succeeded less than or more than n
    case expectedExactly(Int, got: Int)
}

/// A generic error that occured while parsing
public struct GenericParseError: ParseError, Equatable {
    
    /// the message of the error
    public let message: String
    
    /// Compare two instances of GenericParseError
    ///
    /// - Parameters:
    ///   - lhs: the first error to compare with
    ///   - rhs: the second error to compare with
    /// - Returns: true if both messages are equal, false otherwise
    public static func == (lhs: GenericParseError, rhs: GenericParseError) -> Bool {
        return lhs.message == rhs.message
    }
}
