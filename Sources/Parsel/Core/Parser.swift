//
//  Parser.swift
//  Parsel
//
//  Created by Benjamin Herzog on 13.08.17.
//

/// A Parser parses sequences of T (Token) to one or multiple R (Result)
open class Parser<T, R> where T: Sequence {
    
    /// ParseFunction is the type of the wrapped function type
    public typealias ParseFunction = (T) -> ParseResult<T, R>
    
    /// The wrapped function, call to start the parsing process.
    public let parseFunction: ParseFunction
    
    /// Initialize a parser with the given wrapping function.
    ///
    /// - Parameter parse: A function that describes how to parse from T to R
    public init(parse: @escaping ParseFunction) {
        self.parseFunction = parse
    }
    
    /// Start the parsing with that parser
    ///
    /// - Parameter input: the token sequence that should be parsed
    /// - Returns: the result of the parsing operation
    public func parse(_ input: T) -> ParseResult<T, R> {
        return self.parseFunction(input)
    }
    
    /// just creates a parser that parses the given value as success
    ///
    /// - Parameter value: the result to produce
    /// - Returns: a parser that just produces this value as success
    public static func just<B>(_ value: B) -> Parser<T, B> {
        return Parser<T, B> { t in
            return .success(result: value, rest: t)
        }
    }
    
    /// fail creates a parser that fails with the given error.
    ///
    /// - Parameter err: the error that should be used to fail
    /// - Returns: a parser that always fails
    public static func fail(error: ParseError) -> Parser<T, R> {
        return Parser<T, R> { _ in .fail(error) }
    }
    
    /// Creates a parser that always fails with a GenericParseError.
    ///
    /// - Parameter message: the message to use for GenericParseError
    /// - Returns: a parser that always fails
    public static func fail(message: String) -> Parser<T, R> {
        return Parser<T, R> { _ in .fail(GenericParseError(message: message)) }
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
            return Parser.just(f(res))
        }
    }
    
    /// Filter the result of the parser. Could be used for validation.
    ///
    /// - Parameter f: a function that produces an error if the given result should fail instead
    /// - Returns: a parser that parses self and re-evaluates the result with f
    public func filter(_ f: @escaping (R) -> ParseError?) -> Parser<T, R> {
        return self.flatMap({ res in
            if let err = f(res) {
                return Parser.fail(error: err)
            }
            return Parser.just(res)
        })
    }
}
