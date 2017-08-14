//
//  ParserTests.swift
//  ParserCombinatorTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import ParserCombinator

class ParserTests: XCTestCase {
    
    // MARK: - Tests
    
    func test_unit() {
        let p = Parser<String, Int>.unit(3)
        
        let res1 = p.parse("123")
        XCTAssertTrue(res1 == .success(result: 3, rest: "123"))
        
        // state should not change
        let res2 = p.parse("123")
        XCTAssertTrue(res2 == .success(result: 3, rest: "123"))
    }
    
    func test_init_producesSuccess() {
        let p = Parser<String, Int>.unit(1)
        
        let res = p.parse("123")
        XCTAssertTrue(res == .success(result: 1, rest: "123"))
    }
    
    func test_init_producesFail() {
        let p = Parser<String, Int> { str in
            return .fail(TestError(1))
        }
        
        let res = p.parse("123")
        XCTAssertTrue(res == .fail(TestError(1)))
    }
    
    func test_init() {
        let lit = Parser<String, Character> { str in
            guard let first = str.characters.first else {
                return .fail(TestError(1))
            }
            return .success(result: first, rest: String(str.dropFirst()))
        }
        
        let res1 = lit.parse("123")
        XCTAssertTrue(res1 == .success(result: "1", rest: "23"))
        
        let res2 = lit.parse("")
        XCTAssertTrue(res2 == .fail(TestError(1)))
    }
    
    func test_flatMap_success() {
        let doubleA = char("a").flatMap(f: char)
        let res1 = doubleA.parse("aab")
        XCTAssertTrue(res1 == .success(result: "a", rest: "b"))
        
        let doubleAPlusB = doubleA.flatMap(f: { _ in char("b") })
        let res2 = doubleAPlusB.parse("aab")
        XCTAssertTrue(res2 == .success(result: "b", rest: ""))
    }
    
    func test_flatMap_fail() {
        let doubleA = char("a").flatMap(f: char)
        
        let res1 = doubleA.parse("")
        XCTAssertTrue(res1 == .fail(TestError(1)))
        
        let res2 = doubleA.parse("ab")
        XCTAssertTrue(res2 == .fail(TestError(1)))
    }
    
    func test_map() {
        let p = string("abc")
        let pMapped = p.map(f: { $0.count })
        
        let res1 = pMapped.parse("abcde")
        XCTAssertTrue(res1 == .success(result: 3, rest: "de"))
        
        let res2 = pMapped.parse("edcba")
        XCTAssertTrue(res2 == .fail(TestError(1)))
    }
    
}

#if os(Linux)
    extension ParserTests {
        static var allTests : [(String, (ParserTests) -> () throws -> Void)] {
            return [
                ("test_unit", test_unit),
                ("test_init_producesSuccess", test_init_producesSuccess),
                ("test_init_producesFail", test_init_producesFail),
                ("test_init", test_init),
                ("test_flatMap_success", test_flatMap_success),
                ("test_flatMap_fail", test_flatMap_fail),
                ("test_map", test_map),
            ]
        }
    }
#endif
