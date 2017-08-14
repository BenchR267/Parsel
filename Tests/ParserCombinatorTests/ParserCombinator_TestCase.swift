//
//  ParserCombinator_TestCase.swift
//  ParserCombinatorTests
//
//  Created by Benjamin Herzog on 14.08.17.
//

import XCTest
@testable import ParserCombinator

class ParserCombinator_TestCase: XCTestCase {

    func test_addition() {
        
        let addition = (int() ~ char("+") ~ int()).map { a, _, b in
            return a + b
        }
        
        let res = addition.parse("1234+56")
        XCTAssertEqual(1290, try res.unwrap())
    }

}

#if os(Linux)
    extension ParserCombinator_TestCase {
        static var allTests : [(String, (ParserCombinator_TestCase) -> () throws -> Void)] {
            return [
                ("test_addition", test_addition)
            ]
        }
    }
#endif
