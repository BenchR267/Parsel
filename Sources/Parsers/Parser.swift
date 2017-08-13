//
//  Parser.swift
//  ParsersPackageDescription
//
//  Created by Benjamin Herzog on 13.08.17.
//

import Foundation

/// A Parser parses sequences of T (Token) to one or multiple R (Result)
public class Parser<T, R> where T: Sequence {
    
    /// ParseFunction is the type of the wrapped function type
    public typealias ParseFunction = (T) -> [ParseResult<T, R>]
    
    /// The wrapped function, call to start the parsing process.
    let parse: ParseFunction
    
    /// Initialize a parser with the given wrapping function.
    ///
    /// - Parameter parse: A function that describes how to parse from T to R
    public init(parse: @escaping ParseFunction) {
        self.parse = parse
    }
    
    /// unit creates a parser that parses the given value as success
    ///
    /// - Parameter value: the result to produce
    /// - Returns: a parser that just produces this value as success
    static func unit(_ value: R) -> Parser<T, R> {
        return Parser<T, R> { t in
            return [.success(result: value, rest: t)]
        }
    }
}
