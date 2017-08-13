//
//  Sequence+ParseResultTests.swift
//  ParsersTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import Parsers

class Sequence_ParseResultTests: XCTestCase {

    func test_onlySuccess() {
        let p = char("a").or(char("b"))
        let res = p.parse("ab")
        let successes = onlySuccess(res)
        XCTAssertEqual(successes.count, 1)
    }
    
    func test_onlyFails() {
        let p = char("a").or(char("b"))
        let res = p.parse("ab")
        let successes = onlyFails(res)
        XCTAssertEqual(successes.count, 1)
    }

}

#if os(Linux)
    extension Sequence_ParseResultTests {
        static var allTests : [(String, (Sequence_ParseResultTests) -> () throws -> Void)] {
            return [
                ("test_onlySuccess", test_onlySuccess),
                ("test_onlyFails", test_onlyFails),
            ]
        }
    }
#endif
