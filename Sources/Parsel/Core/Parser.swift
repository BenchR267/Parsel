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
    private let parseFunction: ParseFunction
    
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

    /// Starts the parsing with that parser
    ///
    /// - Parameter input: calls self.parse with the given input
    public subscript(_ input: T) -> ParseResult<T, R> {
        return self.parse(input)
    }
    
    /// just creates a parser that parses the given value as success
    ///
    /// - Parameter value: the result to produce
    /// - Returns: a parser that just produces this value as success
    public static func just<B>(_ value: B) -> Parser<T, B> {
        return Parser<T, B> { tokens in
            return .success(result: value, rest: tokens)
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
    /// - Parameter tranform: function that maps a parse result to a new parser
    /// - Returns: a new parser that combines both parse operations.
    public func flatMap<B>(_ tranform: @escaping (R) -> Parser<T, B>) -> Parser<T, B> {
        return Parser<T, B> { tokens in
            return self.parse(tokens).flatMap { result, rest in
                return tranform(result).parse(rest)
            }
        }
    }
    
    /// Produce a new parser which calls f on each successful parsing operation.
    ///
    /// - Parameter transform: transforming function that maps from R to B
    /// - Returns: a new parser that calls f on each successful parsing operation
    public func map<B>(_ transform: @escaping (R) -> B) -> Parser<T, B> {
        return self.flatMap { result -> Parser<T, B> in
            return Parser.just(transform(result))
        }
    }
    
    /// Return another error when parsing failed
    ///
    /// - Parameter transform: a function that maps from the occured error to another one
    /// - Returns: a parser that parses self and transforms the error if failed
    public func mapError(_ transform: @escaping (ParseError) -> ParseError) -> Parser<T, R> {
        return Parser { str in
            return self.parse(str).mapError(transform)
        }
    }
    
    /// Filter the result of the parser. Could be used for validation.
    ///
    /// - Parameter transform: a function that produces an error if the given result should fail instead
    /// - Returns: a parser that parses self and re-evaluates the result with f
    public func filter(_ transform: @escaping (R) -> ParseError?) -> Parser<T, R> {
        return self.flatMap({ res in
            if let err = transform(res) {
                return Parser.fail(error: err)
            }
            return Parser.just(res)
        })
    }
}
