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
        let p1 = char("a").or(char("b"))
        
        let res = p1.parse("ab")
        XCTAssertTrue(res == .success(result: "a", rest: "b"))
        
        let p2 = char("b").or(char("a"))
        
        let res2 = p2.parse("ab")
        XCTAssertTrue(res2 == .success(result: "a", rest: "b"))
    }

    func test_then() {
        let p = char("a").then(char("b"))
        
        let res = p.parse("abc")
        XCTAssertTrue(res == .success(result: "b", rest: "c"))
    }
    
    func test_fallback() {
        let p = char("a").fallback("b")
        
        let res = p.parse("cba")
        XCTAssertTrue(res == .success(result: "b", rest: "cba"))
        
        let res2 = p.parse("abc")
        XCTAssertTrue(res2 == .success(result: "a", rest: "bc"))
    }
}

#if os(Linux)
    extension Parser_ConjunctionTests {
        static var allTests : [(String, (Parser_ConjunctionTests) -> () throws -> Void)] {
            return [
                ("test_or", test_or),
                ("test_then", test_then),
                ("test_fallback", test_fallback)
            ]
        }
    }
#endif
