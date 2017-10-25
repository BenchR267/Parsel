//
//  TestError.swift
//  ParselTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

@testable import Parsel

internal struct TestError: ParseError, Equatable {
    let code: Int
    
    init(_ code: Int) {
        self.code = code
    }
    
    static func ==(lhs: TestError, rhs: TestError) -> Bool {
        return lhs.code == rhs.code
    }
}

internal func char(_ c: Character) -> Parser<String, Character> {
    return Parser { str in
        guard let first = str.first, first == c else {
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
    guard let first = str.first, let number = Int(String(first)) else {
        return .fail(TestError(1))
    }
    return .success(result: number, rest: String(str.dropFirst()))
}

internal let number = digit.atLeastOne.map { Int($0.map(String.init).joined()) ?? 0 }
