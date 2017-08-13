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
        
        let erg = p.parse("ab")
        XCTAssertEqual(erg.count, 2)
        XCTAssertTrue(erg[0] == .success(result: "a", rest: "b"))
        XCTAssertTrue(erg[1] == .fail(TestError(1)))
    }

}
