//
//  Parser+ConjunctionTests.swift
//  ParsersTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import Parsers

class Parser_ConjunctionTests: XCTestCase {

    func test_or() {
        let p = char("a").or(char("b"))
        
        let res = p.parse("ab")
        XCTAssertEqual(res.count, 2)
        XCTAssertTrue(res[0] == .success(result: "a", rest: "b"))
        XCTAssertTrue(res[1] == .fail(TestError(1)))
    }

    func test_then() {
        let p = char("a").then(char("b"))
        
        let res = p.parse("abc")
        XCTAssertEqual(res.count, 1)
        XCTAssertTrue(res[0] == .success(result: "b", rest: "c"))
    }
}
