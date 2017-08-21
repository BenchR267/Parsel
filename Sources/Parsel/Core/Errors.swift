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
}

/// A generic error that occured while parsing
public struct GenericParseError: ParseError, Equatable {
    
    /// the message of the error
    public let message: String
    
    public static func ==(lhs: GenericParseError, rhs: GenericParseError) -> Bool {
        return lhs.message == rhs.message
    }
}
