//
//  ParserTests.swift
//  ParsersTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import Parsers

class ParserTests: XCTestCase {

    func test_init_producesSuccess() {
        let p = Parser<String, Int>.unit(1)
        
        let erg = p.parse("123")
        XCTAssertEqual(erg.count, 1)
        XCTAssertTrue(erg[0] == .success(result: 1, rest: "123"))
    }
    
    func test_init_producesFail() {
        let p = Parser<String, Int> { str in
            return [.fail(TestError(1))]
        }
        
        let erg = p.parse("123")
        XCTAssertEqual(erg.count, 1)
        XCTAssertTrue(erg[0] == .fail(TestError(1)))
    }
    
    func test_unit() {
        let p = Parser<String, Int>.unit(3)
        
        let erg1 = p.parse("123")
        XCTAssertEqual(erg1.count, 1)
        XCTAssertTrue(erg1[0] == .success(result: 3, rest: "123"))
        
        // state should not change
        let erg2 = p.parse("123")
        XCTAssertEqual(erg2.count, 1)
        XCTAssertTrue(erg2[0] == .success(result: 3, rest: "123"))
    }
}
