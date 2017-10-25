//
//  OperatorsTests.swift
//  ParselTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import Parsel

class Operators_TestCase: XCTestCase {

    func test_or_operator_first() {
        let p1 = char("a") | char("b")
        let p2 = char("a").or(char("b"))
        
        let input = "abc"
        let res1 = p1.parse(input)
        let res2 = p2.parse(input)
        
        XCTAssertTrue(res1 == res2)
    }
    
    func test_or_operator_second() {
        let p1 = char("b") | char("a")
        let p2 = char("b").or(char("a"))
        
        let input = "abc"
        let res1 = p1.parse(input)
        let res2 = p2.parse(input)
        
        XCTAssertTrue(res1 == res2)
    }

    func test_then_operator() {
        let p1 = char("a") >> char("b")
        let p2 = char("a").then(char("b"))
        
        let input = "abc"
        let res1 = p1.parse(input)
        let res2 = p2.parse(input)
        
        XCTAssertTrue(res1 == res2)
    }
    
    func test_map_operator() {
        let f: (String) -> Int = { $0.count }
        let p = string("abc") ^^ f
        
        let res = p.parse("abcde")
        XCTAssertTrue(res == .success(result: 3, rest: "de"))
    }
    
    func test_map_operator_precendence() {
        let p = char("a") >> char("b") ^^ { String($0).unicodeScalars.first?.value ?? 0 }
        let res = p.parse("abc")
        
        XCTAssertTrue(res == .success(result: 98, rest: "c"))
    }
    
    func test_map_operator_value() {
        let p = string("abc") ^^^ "cba"
        
        let res = p.parse("abcde")
        XCTAssertTrue(res == .success(result: "cba", rest: "de"))
    }
    
    func test_atLeastOnce_operator() {
        let p1 = char("a")+
        
        let res1 = p1.parse("aaaa")
        XCTAssertEqual(try res1.unwrap(), ["a", "a", "a", "a"])
        
        let res2 = p1.parse("b")
        XCTAssertTrue(res2.isFailed())
    }
    
    func test_rep_operator() throws {
        let p = char("a")*
        
        let res1 = p.parse("aa")
        XCTAssertEqual(try res1.unwrap(), ["a", "a"])
        
        let res2 = p.parse("bb")
        XCTAssertEqual(try res2.unwrap(), [])
    }
    
    func test_rep_fail_operator() throws {
        let res1 = digit.rep.parse("a")
        XCTAssertEqual(try res1.unwrap(), [])
    }
    
    func test_fallback_operator() throws {
        let p1 = char("a") ?? "b"
        let p2 = char("a").fallback("b")
        
        let input = "cba"
        let res1 = p1.parse(input)
        let res2 = p2.parse(input)
        XCTAssertTrue(res1 == res2)
        
        let p3 = char("a").map({ $0.description }) ?? digit.map({ $0.description })
        let res3 = p3.parse("1")
        XCTAssertEqual(try res3.unwrap(), "1")
        let res4 = p3.parse("a")
        XCTAssertEqual(try res4.unwrap(), "a")
        let res5 = p3.parse("b")
        XCTAssertTrue(res5.isFailed())
    }
    
    func test_precedence() throws {
        // ~ has higher presedence than ^^
        let p = char("a") ~> char("b") <~ char("c") ^^ { String($0) }
        let res1 = p.parse("abcd")
        XCTAssertEqual(try res1.unwrap(), "b")
        XCTAssertEqual(try res1.rest(), "d")
        
        // >> has higher precedence than ^^
        let p2 = char("a") >> char("b") ^^ { L.asciiValue(from: $0) }
        XCTAssertEqual(try p2.parse("ab").unwrap(), L.asciiValue(from: "b"))
        
        // + and * have highest precedence
        let p3 = char("a")* ~ char("b")+ ^^ { ($0.0.count, String($0.1)) }
        let res2 = try p3.parse("aaaaaaaaabbb").unwrap()
        XCTAssertEqual(res2.0, 9)
        XCTAssertEqual(res2.1, "bbb")
        
        // ?? has highest priority
        let p4 = char("a") ?? "a" ~ digit
        let res3 = try p4.parse("a4").unwrap()
        XCTAssertEqual(res3.0, "a")
        XCTAssertEqual(res3.1, 4)
        let res4 = try p4.parse("4").unwrap()
        XCTAssertEqual(res4.0, "a")
        XCTAssertEqual(res4.1, 4)
    }
    
    func test_patternMatching() {
        switch "abc" {
        case L.asciiString: ()
        default: XCTFail("'abc' did not match L.asciiString")
        }
        
        switch "a" {
        case L.char: ()
        default: XCTFail("'a' did not match L.char'")
        }
        
        switch "abc" {
        case L.char: XCTFail("'abc' should not match L.char because not the whole String matches")
        case L.digit: XCTFail("'abc' is no digit")
        case L.string(length: 3): ()
        default: XCTFail("'abc' should have matched L.string(length: 3) before")
        }
    }
}

#if os(Linux)
    extension Operators_TestCase {
        static var allTests = [
            ("test_or_operator_first", test_or_operator_first),
            ("test_or_operator_second", test_or_operator_second),
            ("test_then_operator", test_then_operator),
            ("test_map_operator", test_map_operator),
            ("test_map_operator_precendence", test_map_operator_precendence),
            ("test_map_operator_value", test_map_operator_value),
            ("test_atLeastOnce_operator", test_atLeastOnce_operator),
            ("test_rep_operator", test_rep_operator),
            ("test_rep_fail_operator", test_rep_fail_operator),
            ("test_fallback_operator", test_fallback_operator),
            ("test_precedence", test_precedence),
            ("test_patternMatching", test_patternMatching),
        ]
    }
#endif
