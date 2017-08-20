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

public struct GenericParseError: ParseError, Equatable {
    public let message: String
    
    public var code: UInt64 {
        return UInt64(abs(message.hashValue))
    }
    
    public static func ==(lhs: GenericParseError, rhs: GenericParseError) -> Bool {
        return lhs.message == rhs.message
    }
}
