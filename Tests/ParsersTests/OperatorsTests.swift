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
        
        for (r1, r2) in zip(res1, res2) {
            XCTAssertTrue(r1 == r2)
        }
    }

    func test_then_operator() {
        let p1 = char("a") >> char("b")
        let p2 = char("a").then(char("b"))
        
        let input = "abc"
        let res1 = p1.parse(input)
        let res2 = p2.parse(input)
        
        for (r1, r2) in zip(res1, res2) {
            XCTAssertTrue(r1 == r2)
        }
    }
    
    func test_map_operator() {
        let f: (String) -> Int = { $0.count }
        let p = string("abc") ^^ f
        
        let res = p.parse("abcde")
        XCTAssertEqual(res.count, 1)
        XCTAssertTrue(res[0] == .success(result: 3, rest: "de"))
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
