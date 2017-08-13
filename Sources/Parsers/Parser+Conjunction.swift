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
            return self.parse(tokens) + other().parse(tokens)
        }
    }
    
}
