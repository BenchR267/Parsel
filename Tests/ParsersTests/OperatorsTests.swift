//
//  OperatorsTests.swift
//  ParsersTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import Parsers

class OperatorsTests: XCTestCase {

    func test_or_operator() {
        let p1 = char("a") || char("b")
        let p2 = char("a").or(char("b"))
        
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
    
}

#if os(Linux)
    extension OperatorsTests {
        static var allTests : [(String, (OperatorsTests) -> () throws -> Void)] {
            return [
                ("test_or_operator", test_or_operator),
                ("test_then_operator", test_then_operator),
                ("test_map_operator", test_map_operator)
            ]
        }
    }
#endif
