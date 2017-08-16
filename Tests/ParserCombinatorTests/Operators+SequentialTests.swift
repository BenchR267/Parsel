//
//  Operators+SequentialTests.swift
//  ParserCombinatorTests
//
//  Created by Benjamin Herzog on 14.08.17.
//

import XCTest
@testable import ParserCombinator

class Operators_SequentialTests: XCTestCase {
    
    func test_sequential_success() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f") ~ char("g") ~ char("h") ~ char("i") ~ char("j") ~ char("k")
        let input = "abcdefghijk"
        let res = p.parse(input)
        let value = try res.unwrap()
        XCTAssertEqual(value.0, "a")
        XCTAssertEqual(value.1, "b")
        XCTAssertEqual(value.2, "c")
        XCTAssertEqual(value.3, "d")
        XCTAssertEqual(value.4, "e")
        XCTAssertEqual(value.5, "f")
        XCTAssertEqual(value.6, "g")
        XCTAssertEqual(value.7, "h")
        XCTAssertEqual(value.8, "i")
        XCTAssertEqual(value.9, "j")
        XCTAssertEqual(value.10, "k")
        
        let p2 = char("a") <~ (char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f") ~ char("g") ~ char("h") ~ char("i") ~ char("j") ~ char("k"))
        XCTAssertEqual(try p2.parse(input).unwrap(), "a")
        
        let p3 = (char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f") ~ char("g") ~ char("h") ~ char("i") ~ char("j")) >~ char("k")
        XCTAssertEqual(try p3.parse(input).unwrap(), "k")
    }
    
    func test_sequential_fail() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f") ~ char("g") ~ char("h") ~ char("i") ~ char("j") ~ char("k")
        let res = p.parse("a")
        XCTAssertTrue(try res.error().code == 1)
    }
    
    func test_sequential() {
        let p1 = char("a") >~ char("b")
        let p2 = char("a") <~ char("b")
        
        let input = "ab"
        XCTAssertEqual(try p1.parse(input).unwrap(), "b")
        XCTAssertEqual(try p2.parse(input).unwrap(), "a")
        
        let p3 = number <~ char("a")
        XCTAssertEqual(try p3.parse("1234a").unwrap(), 1234)
        
        let p4 = char("a").rep ^^ { String($0) }
        XCTAssertEqual(try p4.parse("aaaa").unwrap(), "aaaa")
    }
    
    func test_sequential_otherWayAround() throws {
        let p = char("a") ~ (char("b") ~ (char("c") ~ (char("d") ~ (char("e") ~ (char("f") ~ (char("g") ~ (char("h") ~ (char("i") ~ (char("j") ~ char("k"))))))))))
        let input = "abcdefghijk"
        let res = p.parse(input)
        let value = try res.unwrap()
        XCTAssertEqual(value.0, "a")
        XCTAssertEqual(value.1, "b")
        XCTAssertEqual(value.2, "c")
        XCTAssertEqual(value.3, "d")
        XCTAssertEqual(value.4, "e")
        XCTAssertEqual(value.5, "f")
        XCTAssertEqual(value.6, "g")
        XCTAssertEqual(value.7, "h")
        XCTAssertEqual(value.8, "i")
        XCTAssertEqual(value.9, "j")
        XCTAssertEqual(value.10, "k")
        
        let p2 = char("a") <~ (char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f") ~ char("g") ~ char("h") ~ char("i") ~ char("j") ~ char("k"))
        XCTAssertEqual(try p2.parse(input).unwrap(), "a")
        
        let p3 = (char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f") ~ char("g") ~ char("h") ~ char("i") ~ char("j")) >~ char("k")
        XCTAssertEqual(try p3.parse(input).unwrap(), "k")
    }
    
}

#if os(Linux)
    extension Operators_SequentialTests {
        static var allTests : [(String, (Operators_SequentialTests) -> () throws -> Void)] {
            return [
                ("test_sequential_success", test_sequential_success),
                ("test_sequential_fail", test_sequential_fail),
                ("test_sequential", test_sequential),
                ("test_sequential_otherWayAround", test_sequential_otherWayAround),
            ]
        }
    }
#endif
