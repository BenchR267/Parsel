//
//  Parser.swift
//  ParserCombinator
//
//  Created by Benjamin Herzog on 13.08.17.
//

/// A Parser parses sequences of T (Token) to one or multiple R (Result)
open class Parser<T, R> where T: Sequence {
    
    /// ParseFunction is the type of the wrapped function type
    public typealias ParseFunction = (T) -> ParseResult<T, R>
    
    /// The wrapped function, call to start the parsing process.
    public let parse: ParseFunction
    
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
    public static func unit<B>(_ value: B) -> Parser<T, B> {
        return Parser<T, B> { t in
            return .success(result: value, rest: t)
        }
    }
    
    public static func fail<B>(_ err: ParseError) -> Parser<T, B> {
        return Parser<T, B> { t in
            return .fail(err)
        }
    }
    
    /// Produce a new parser for every succeeded parsing process.
    ///
    /// - Parameter f: function that maps a parse result to a new parser
    /// - Returns: a new parser that combines both parse operations.
    public func flatMap<B>(_ f: @escaping (R) -> Parser<T, B>) -> Parser<T, B> {
        return Parser<T, B> { tokens in
            return self.parse(tokens).flatMap { r, t in
                return f(r).parse(t)
            }
        }
    }
    
    /// Produce a new parser which calls f on each successful parsing operation.
    ///
    /// - Parameter f: transforming function that maps from R to B
    /// - Returns: a new parser that calls f on each successful parsing operation
    public func map<B>(_ f: @escaping (R) -> B) -> Parser<T, B> {
        return self.flatMap { res -> Parser<T, B> in
            return Parser.unit(f(res))
        }
    }
    
}
