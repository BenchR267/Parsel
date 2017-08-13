//
//  TestError.swift
//  ParsersTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import Foundation
@testable import Parsers

internal struct TestError: ParseError, Equatable {
    let code: UInt64
    
    init(_ code: UInt64) {
        self.code = code
    }
    
    static func ==(lhs: TestError, rhs: TestError) -> Bool {
        return lhs.code == rhs.code
    }
}
