//
//  ParseResult.swift
//  ParsersPackageDescription
//
//  Created by Benjamin Herzog on 13.08.17.
//

import Foundation

public protocol ParseError: Swift.Error {
    var code: UInt64 { get }
}

/// ParseErrors are the same if their code matches
public func ==(lhs: ParseError, rhs: ParseError) -> Bool {
    return lhs.code == rhs.code
}

public enum ParseResult<Token, Result> where Token: Sequence {
    
    case success(result: Result, rest: Token)
    
    case fail(ParseError)
    
    /// Transforms the result with f, if successful.
    ///
    /// - Parameter f: a function to use to transform result
    /// - Returns: ParseResult with transformed result or fail with unchanged error.
    public func map<B>(f: (Result) -> B) -> ParseResult<Token, B> {
        switch self {
        case let .success(result, rest):
            return .success(result: f(result), rest: rest)
        case let .fail(err):
            return .fail(err)
        }
    }
    
    // TODO: Declaration seems wrong, maybe needs to be changed
    public func flatMap<B>(f: (Result, Token) -> ParseResult<Token, B>) -> ParseResult<Token, B> {
        switch self {
        case let .success(result, rest):
            return f(result, rest)
        case let .fail(err):
            return .fail(err)
        }
    }
    
    /// Unwraps the result from the success case.
    ///
    /// - Returns: the result if success
    /// - Throws: Errors.unwrappedFailedResult if not successful
    func unwrap() throws -> Result {
        switch self {
        case let .success(result, _):
            return result
        default:
            throw Errors.unwrappedFailedResult
        }
    }
    
    /// Unwraps the error if not successful
    ///
    /// - Returns: the parsing error if not successful
    /// - Throws: Errors.errorFromSuccessfulResult if successful
    func error() throws -> ParseError {
        switch self {
        case let .fail(err):
            return err
        default:
            throw Errors.errorFromSuccessfulResult
        }
    }
    
}

// Hack until extensions with protocol conformance with constraints are possible
public func ==<T, R>(rhs: ParseResult<T, R>, lhs: ParseResult<T, R>) -> Bool where T: Equatable, R: Equatable {
    switch (rhs, lhs) {
    case let (.success(res1, rest1), .success(res2, rest2)):
        return res1 == res2 && rest1 == rest2
    case let (.fail(err1), .fail(err2)):
        return err1 == err2
    default:
        return false
    }
}
