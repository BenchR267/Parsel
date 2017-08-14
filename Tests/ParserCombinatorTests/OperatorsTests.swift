//
//  OperatorsTests.swift
//  ParserCombinatorTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import ParserCombinator

class OperatorsTests: XCTestCase {

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
    
    func test_fallback_operator() {
        let p1 = char("a") ?? "b"
        let p2 = char("a").fallback("b")
        
        let input = "cba"
        let res1 = p1.parse(input)
        let res2 = p2.parse(input)
        XCTAssertTrue(res1 == res2)
    }
    
}

#if os(Linux)
    extension OperatorsTests {
        static var allTests : [(String, (OperatorsTests) -> () throws -> Void)] {
            return [
                ("test_or_operator_first", test_or_operator_first),
                ("test_or_operator_second", test_or_operator_second),
                ("test_then_operator", test_then_operator),
                ("test_map_operator", test_map_operator),
                ("test_map_operator_precendence", test_map_operator_precendence),
                ("test_fallback_operator", test_fallback_operator)
            ]
        }
    }
#endif
