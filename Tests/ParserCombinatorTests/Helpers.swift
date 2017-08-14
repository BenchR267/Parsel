//
//  TestError.swift
//  ParserCombinatorTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import Foundation
@testable import ParserCombinator

internal struct TestError: ParseError, Equatable {
    let code: UInt64
    
    init(_ code: UInt64) {
        self.code = code
    }
    
    static func ==(lhs: TestError, rhs: TestError) -> Bool {
        return lhs.code == rhs.code
    }
}

internal func char(_ c: Character) -> Parser<String, Character> {
    return Parser { str in
        guard let first = str.characters.first, first == c else {
            return .fail(TestError(1))
        }
        return .success(result: first, rest: String(str.dropFirst()))
    }
}

internal func string(_ s: String) -> Parser<String, String> {
    return Parser { str in
        guard str.hasPrefix(s) else {
            return .fail(TestError(1))
        }
        return .success(result: s, rest: String(str.dropFirst(s.count)))
    }
}

internal let digit = Parser<String, Int> { str in
    guard let first = str.characters.first, let number = Int(String(first)) else {
        return .fail(TestError(1))
    }
    return .success(result: number, rest: String(str.dropFirst()))
}

extension Parser {
    
    var rep: Parser<T, [R]> {
        return Parser<T, [R]> { tokens in
            var results = [R]()
            var totalRest = tokens
            
            while case let .success(result, rest) = self.parse(totalRest) {
                results.append(result)
                totalRest = rest
            }
            
            if results.count > 0 {
                return .success(result: results, rest: totalRest)
            } else {
                return .fail(TestError(1))
            }
        }
    }
    
}

internal let number = digit.rep.map { numbers in Int(numbers.map(String.init).joined()) ?? 0 }
