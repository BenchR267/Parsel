//
//  Parser+ConjunctionTests.swift
//  ParselTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import parsel

class Parser_Conjunction_TestCase: XCTestCase {

    func test_or() {
        let p1 = char("a").or(char("b"))
        
        let res = p1.parse("ab")
        XCTAssertTrue(res == .success(result: "a", rest: "b"))
        
        let p2 = char("b").or(char("a"))
        
        let res2 = p2.parse("ab")
        XCTAssertTrue(res2 == .success(result: "a", rest: "b"))
    }
    
    func test_or_sequence() throws {
        let zero = string("0")
        let oneToNine = (1...9).map({string(String($0))})
        let p = zero.or(oneToNine) ^^ { Int($0)! }
        
        let res1 = p.parse("0")
        XCTAssertEqual(try res1.unwrap(), 0)
        
        let res2 = p.parse("3")
        XCTAssertEqual(try res2.unwrap(), 3)
        
        let res3 = p.parse("a")
        XCTAssertTrue(res3.isFailed())
    }
    
    func test_or_static_collection() throws {
        let zeroToNine = (0...9).map({string(String($0))})
        let p = Parser.or(zeroToNine) ^^ { Int($0)! }
        
        let res1 = p.parse("0")
        XCTAssertEqual(try res1.unwrap(), 0)
        
        let res2 = p.parse("3")
        XCTAssertEqual(try res2.unwrap(), 3)
        
        let res3 = p.parse("a")
        XCTAssertTrue(res3.isFailed())
    }
    
    func test_or_static_collection_fail() throws {
        let p = Parser.or([Parser<String, String>]())
        
        let res = p.parse("a")
        
        XCTAssertTrue(res.isFailed())
        
        guard case .conjunctionOfEmptyCollection = try res.error() as! Errors else {
            return XCTFail()
        }
    }

    func test_then() {
        let p = char("a").then(char("b"))
        
        let res = p.parse("abc")
        XCTAssertTrue(res == .success(result: "b", rest: "c"))
    }
    
    func test_fallback() {
        let p = char("a").fallback("b")
        
        let res = p.parse("cba")
        XCTAssertTrue(res == .success(result: "b", rest: "cba"))
        
        let res2 = p.parse("abc")
        XCTAssertTrue(res2 == .success(result: "a", rest: "bc"))
    }
    
    func test_fallback_parser() {
        let p1 = char("a")
        let p2 = char("b")
        
        let p = p1 ?? p2
        
        XCTAssertEqual(try p.parse("a").unwrap(), "a")
        XCTAssertEqual(try p.parse("b").unwrap(), "b")
        XCTAssertThrowsError(try p.parse("c").unwrap())
    }
    
    func test_atLeastOnce() throws {
        let p1 = char("a").atLeastOnce
        
        let res1 = p1.parse("aaaa")
        XCTAssertEqual(try res1.unwrap(), ["a", "a", "a", "a"])
        
        let res2 = p1.parse("b")
        XCTAssertTrue(res2.isFailed())
    }
    
    func test_atLeast_count() throws {
        let p1 = char("a").atLeast(count: 4)
        
        let res1 = p1.parse("aaaa")
        XCTAssertEqual(try res1.unwrap(), ["a", "a", "a", "a"])
        
        let res2 = p1.parse("aaaaa")
        XCTAssertEqual(try res2.unwrap(), ["a", "a", "a", "a", "a"])
        
        let res3 = p1.parse("aaa")
        guard case let .expectedAtLeast(count, got: got) = try res3.error() as! Errors else {
            return XCTFail()
        }
        XCTAssertEqual(count, 4)
        XCTAssertEqual(got, 3)
    }
    
    func test_exactly() throws {
        let p = char("a").exactly(count: 4)
        
        let res1 = p.parse("aaaa")
        XCTAssertEqual(try res1.unwrap(), ["a", "a", "a", "a"])
        
        let res2 = p.parse("aaaaa")
        XCTAssertEqual(try res2.unwrap(), ["a", "a", "a", "a"])
        
        let res3 = p.parse("aaa")
        XCTAssertEqual(try res3.error() as! TestError, TestError(1))
    }
    
    func test_atLeastOnce_sep() throws {
        let p1 = char("a").atLeastOnce(sep: string(", "))
        
        let res1 = p1.parse("a, a, a, a")
        XCTAssertEqual(try res1.unwrap(), ["a", "a", "a", "a"])
        
        let res2 = p1.parse("aaaa")
        XCTAssertEqual(try res2.unwrap(), ["a"])
        
        let res3 = p1.parse("b")
        XCTAssertTrue(res3.isFailed())
    }
    
    func test_rep() throws {
        let list = char("[") >~ digit.rep(sep: string(", ")) <~ char("]")
        let result = list.parse("[1, 2, 3, 4]")
        XCTAssertEqual(try result.unwrap(), [1, 2, 3, 4])
    }
    
    func test_rep2() throws {
        let result = number.parse("1234")
        XCTAssertEqual(try result.unwrap(), 1234)
    }
    
    func test_rep_fail() throws {
        let res1 = digit.rep.parse("a")
        XCTAssertEqual(try res1.unwrap(), [])
        
        let res2 = digit.rep(sep: char("+")).parse("-5+4")
        XCTAssertEqual(try res2.unwrap(), [])
    }
    
    func test_typeErased() throws {
        let p = char("a")
        let t = p.typeErased
        
        let input = "abc"
        let res1 = p.parse(input)
        let res2 = t.parse(input)
        
        XCTAssertTrue(res1.isSuccess())
        XCTAssertTrue(res2.isSuccess())
        
        XCTAssertEqual(try res1.rest(), try res2.rest())
        
        let input2 = "bca"
        let res3 = p.parse(input2)
        let res4 = t.parse(input2)
        
        XCTAssertTrue(res3.isFailed())
        XCTAssertTrue(res4.isFailed())
    }
    
    func test_optional() throws {
        let p1 = char("a").optional
        
        let res1 = p1.parse("abc")
        XCTAssertEqual(try res1.unwrap(), "a")
        XCTAssertEqual(try res1.rest(), "bc")
        
        let res2 = p1.parse("cba")
        XCTAssertTrue(res2.isSuccess())
        XCTAssertEqual(try res2.unwrap(), nil)
        XCTAssertEqual(try res2.rest(), "cba")
    }
}

#if os(Linux)
    extension Parser_Conjunction_TestCase {
        static var allTests = [
            ("test_or", test_or),
            ("test_or_sequence", test_or_sequence),
            ("test_or_static_collection", test_or_static_collection),
            ("test_or_static_collection_fail", test_or_static_collection_fail),
            ("test_then", test_then),
            ("test_fallback", test_fallback),
            ("test_fallback_parser", test_fallback_parser),
            ("test_atLeastOnce", test_atLeastOnce),
            ("test_atLeast_count", test_atLeast_count),
            ("test_exactly", test_exactly),
            ("test_atLeastOnce_sep", test_atLeastOnce_sep),
            ("test_rep", test_rep),
            ("test_rep2", test_rep2),
            ("test_rep_fail", test_rep_fail),
            ("test_typeErased", test_typeErased),
            ("test_optional", test_optional),
        ]
    }
#endif
