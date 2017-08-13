//
//  Parser+Conjunction.swift
//  ParsersTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import Foundation

extension Parser {
    
    /// Concatenates the results of both parsers.
    ///
    /// - Parameter other: another parser which results should be added
    /// - Returns: a parser that contains both parsing results.
    public func or(_ other: @escaping @autoclosure () -> Parser<T, R>) -> Parser<T, R> {
        return Parser { tokens in
            let result = self.parse(tokens)
            switch result {
            case .fail(_):
                return other().parse(tokens)
            default:
                return result
            }
        }
    }
    
    /// Discards the result of self and executes other afterwards on the rest.
    ///
    /// - Parameter other: another parser to execute afterwards
    /// - Returns: a parser that first parses self and then other on the rest of self
    public func then<B>(_ other: @escaping @autoclosure () -> Parser<T, B>) -> Parser<T, B> {
        return self.flatMap(f: { _ in other() })
    }
    
    /// Provides a fallback if the parser fails.
    ///
    /// - Parameter defaultValue: a value that should be parsed instead.
    /// - Returns: a parser that tries to parse and uses defaultValue if parsing failed.
    ///
    /// *NOTE* If parsing fails, there are no tokens consumed!
    public func fallback(_ defaultValue: @escaping @autoclosure () -> R) -> Parser<T, R> {
        return Parser { tokens in
            let result = self.parse(tokens)
            switch result {
            case .fail(_):
                return .success(result: defaultValue(), rest: tokens)
            default:
                return result
            }
        }
    }
    
}
