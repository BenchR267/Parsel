//
//  ParserTests.swift
//  ParsersTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import Parsers

// MARK: - Helpers

func char(_ c: Character) -> Parser<String, Character> {
    return Parser { str in
        guard let first = str.characters.first, first == c else {
            return [.fail(TestError(1))]
        }
        return [.success(result: first, rest: String(str.dropFirst()))]
    }
}

func string(_ s: String) -> Parser<String, String> {
    return Parser { str in
        guard str.hasPrefix(s) else {
            return [.fail(TestError(1))]
        }
        return [.success(result: s, rest: String(str.dropFirst(s.count)))]
    }
}

class ParserTests: XCTestCase {
    
    // MARK: - Tests
    
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
    
    func test_init() {
        let lit = Parser<String, Character> { str in
            guard let first = str.characters.first else {
                return [.fail(TestError(1))]
            }
            return [.success(result: first, rest: String(str.dropFirst()))]
        }
        
        let erg1 = lit.parse("123")
        XCTAssertEqual(erg1.count, 1)
        XCTAssertTrue(erg1[0] == .success(result: "1", rest: "23"))
        
        let erg2 = lit.parse("")
        XCTAssertEqual(erg2.count, 1)
        XCTAssertTrue(erg2[0] == .fail(TestError(1)))
    }
    
    func test_flatMap_success() {
        let doubleA = char("a").flatMap(f: char)
        let erg1 = doubleA.parse("aab")
        XCTAssertEqual(erg1.count, 1)
        XCTAssertTrue(erg1[0] == .success(result: "a", rest: "b"))
        
        let doubleAPlusB = doubleA.flatMap(f: { _ in char("b") })
        let erg2 = doubleAPlusB.parse("aab")
        XCTAssertEqual(erg2.count, 1)
        XCTAssertTrue(erg2[0] == .success(result: "b", rest: ""))
    }
    
    func test_flatMap_fail() {
        let doubleA = char("a").flatMap(f: char)
        
        let erg1 = doubleA.parse("")
        XCTAssertEqual(erg1.count, 1)
        XCTAssertTrue(erg1[0] == .fail(TestError(1)))
        
        let erg2 = doubleA.parse("ab")
        XCTAssertEqual(erg2.count, 1)
        XCTAssertTrue(erg2[0] == .fail(TestError(1)))
    }
    
    func test_map() {
        let p = string("abc")
        let pMapped = p.map(f: { $0.count })
        
        let erg1 = pMapped.parse("abcde")
        XCTAssertEqual(erg1.count, 1)
        XCTAssertTrue(erg1[0] == .success(result: 3, rest: "de"))
        
        let erg2 = pMapped.parse("edcba")
        XCTAssertEqual(erg2.count, 1)
        XCTAssertTrue(erg2[0] == .fail(TestError(1)))
    }
    
}
