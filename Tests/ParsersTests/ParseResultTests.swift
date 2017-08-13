//
//  ParseResult_TestCase.swift
//  ParsersPackageDescription
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import Parsers

class ParseResultTests: XCTestCase {
    
    func test_map_success() {
        let res = ParseResult.success(result: 1, rest: "+2")
        
        let mappedRes1 = res.map(f: {$0 + 1})
        XCTAssertTrue(mappedRes1 == ParseResult.success(result: 2, rest: "+2"))
        XCTAssertTrue(type(of: mappedRes1) == ParseResult<String, Int>.self)
        
        let mappedRes2 = res.map(f: { $0.description })
        XCTAssertTrue(mappedRes2 == ParseResult.success(result: "1", rest: "+2"))
        XCTAssertTrue(type(of: mappedRes2) == ParseResult<String, String>.self)
    }
    
    func test_map_fail() {
        let res = ParseResult<String, Int>.fail(TestError(1))
        let mappedRes = res.map(f: { $0 + 1})
        XCTAssertTrue(res == mappedRes)
    }
    
    func validate<R>(_ value: Int, _ rest: R) -> ParseResult<R, Int> {
        guard value < 10 else {
            return .fail(TestError(1))
        }
        return .success(result: value, rest: rest)
    }
    
    func test_flatMap_success() {
        var res = ParseResult.success(result: 1, rest: "+2")
        let mappedRes1 = res.flatMap(f: validate)
        
        XCTAssertTrue(mappedRes1 == res)
        
        res = ParseResult.success(result: 10, rest: "+2")
        let mappedRes2 = res.flatMap(f: validate)
        XCTAssertTrue(mappedRes2 == .fail(TestError(1)))
    }
    
    func test_flatMap_fail() {
        let res = ParseResult<String, Int>.fail(TestError(1))
        let mappedRes = res.flatMap(f: validate)
        XCTAssertTrue(res == mappedRes)
    }
    
    func test_equal() {
        var res1 = ParseResult.success(result: 1, rest: "2")
        var res2 = ParseResult.success(result: 1, rest: "2")
        XCTAssertTrue(res1 == res2)
        
        res1 = .success(result: 1, rest: "2")
        res2 = .success(result: 2, rest: "2")
        XCTAssertFalse(res1 == res2)
        
        res1 = .success(result: 1, rest: "2")
        res2 = .success(result: 1, rest: "3")
        XCTAssertFalse(res1 == res2)
        
        res1 = .fail(TestError(1))
        res2 = .fail(TestError(1))
        XCTAssertTrue(res1 == res2)
        
        res1 = .fail(TestError(1))
        res2 = .fail(TestError(2))
        XCTAssertFalse(res1 == res2)
        
        res1 = .success(result: 1, rest: "2")
        res2 = .fail(TestError(1))
        XCTAssertFalse(res1 == res2)
    }
}
