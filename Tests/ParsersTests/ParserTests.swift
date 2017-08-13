//
//  ParserTests.swift
//  ParsersTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import Parsers

class ParserTests: XCTestCase {
    
    // MARK: - Tests
    
    func test_unit() {
        let p = Parser<String, Int>.unit(3)
        
        let res1 = p.parse("123")
        XCTAssertEqual(res1.count, 1)
        XCTAssertTrue(res1[0] == .success(result: 3, rest: "123"))
        
        // state should not change
        let res2 = p.parse("123")
        XCTAssertEqual(res2.count, 1)
        XCTAssertTrue(res2[0] == .success(result: 3, rest: "123"))
    }
    
    func test_init_producesSuccess() {
        let p = Parser<String, Int>.unit(1)
        
        let res = p.parse("123")
        XCTAssertEqual(res.count, 1)
        XCTAssertTrue(res[0] == .success(result: 1, rest: "123"))
    }
    
    func test_init_producesFail() {
        let p = Parser<String, Int> { str in
            return [.fail(TestError(1))]
        }
        
        let res = p.parse("123")
        XCTAssertEqual(res.count, 1)
        XCTAssertTrue(res[0] == .fail(TestError(1)))
    }
    
    func test_init() {
        let lit = Parser<String, Character> { str in
            guard let first = str.characters.first else {
                return [.fail(TestError(1))]
            }
            return [.success(result: first, rest: String(str.dropFirst()))]
        }
        
        let res1 = lit.parse("123")
        XCTAssertEqual(res1.count, 1)
        XCTAssertTrue(res1[0] == .success(result: "1", rest: "23"))
        
        let res2 = lit.parse("")
        XCTAssertEqual(res2.count, 1)
        XCTAssertTrue(res2[0] == .fail(TestError(1)))
    }
    
    func test_flatMap_success() {
        let doubleA = char("a").flatMap(f: char)
        let res1 = doubleA.parse("aab")
        XCTAssertEqual(res1.count, 1)
        XCTAssertTrue(res1[0] == .success(result: "a", rest: "b"))
        
        let doubleAPlusB = doubleA.flatMap(f: { _ in char("b") })
        let res2 = doubleAPlusB.parse("aab")
        XCTAssertEqual(res2.count, 1)
        XCTAssertTrue(res2[0] == .success(result: "b", rest: ""))
    }
    
    func test_flatMap_fail() {
        let doubleA = char("a").flatMap(f: char)
        
        let res1 = doubleA.parse("")
        XCTAssertEqual(res1.count, 1)
        XCTAssertTrue(res1[0] == .fail(TestError(1)))
        
        let res2 = doubleA.parse("ab")
        XCTAssertEqual(res2.count, 1)
        XCTAssertTrue(res2[0] == .fail(TestError(1)))
    }
    
    func test_map() {
        let p = string("abc")
        let pMapped = p.map(f: { $0.count })
        
        let res1 = pMapped.parse("abcde")
        XCTAssertEqual(res1.count, 1)
        XCTAssertTrue(res1[0] == .success(result: 3, rest: "de"))
        
        let res2 = pMapped.parse("edcba")
        XCTAssertEqual(res2.count, 1)
        XCTAssertTrue(res2[0] == .fail(TestError(1)))
    }
    
}
