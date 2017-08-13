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
    
}
