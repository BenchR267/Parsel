//
//  Errors.swift
//  Parsel
//
//  Created by Benjamin Herzog on 13.08.17.
//

public enum Errors: Int, ParseError {
    case unwrappedFailedResult = 0
    case errorFromSuccessfulResult = 1
    case conjunctionOfEmptyCollection = 2
    case expectedAtLeastOnce = 3
}

public struct GenericParseError: ParseError, Equatable {
    public let message: String
    
    public static func ==(lhs: GenericParseError, rhs: GenericParseError) -> Bool {
        return lhs.message == rhs.message
    }
}
