//
//  Errors.swift
//  ParserCombinator
//
//  Created by Benjamin Herzog on 13.08.17.
//

public enum Errors: UInt64, ParseError {
    
    case unwrappedFailedResult = 0
    case errorFromSuccessfulResult = 1
    case conjunctionOfEmptyCollection = 2
    case expectedAtLeastOnce = 3
    
    public var code: UInt64 {
        return self.rawValue
    }
}
