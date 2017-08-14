//
//  Operators+SequentialTests.swift
//  ParserCombinatorTests
//
//  Created by Benjamin Herzog on 14.08.17.
//

import XCTest
@testable import ParserCombinator

class Operators_SequentialTests: XCTestCase {

    func test_sequential_success_1() throws {
        let p = char("a") ~ char("b")
        let res = p.parse("ab")
        let value = try res.unwrap()
        XCTAssertEqual(value.0, "a")
        XCTAssertEqual(value.1, "b")
    }
    
    func test_sequential_fail_1() throws {
        let p = char("a") ~ char("b")
        let res = p.parse("b")
        XCTAssertTrue(try res.error().code == 1)
    }
    
    func test_sequential_success_2() throws {
        let p = char("a") ~ char("b") ~ char("c")
        let res = p.parse("abc")
        let value = try res.unwrap()
        XCTAssertEqual(value.0, "a")
        XCTAssertEqual(value.1, "b")
        XCTAssertEqual(value.2, "c")
    }
    
    func test_sequential_fail_2() throws {
        let p = char("a") ~ char("b") ~ char("c")
        let res = p.parse("a")
        XCTAssertTrue(try res.error().code == 1)
    }
    
    func test_sequential_success_3() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d")
        let res = p.parse("abcd")
        let value = try res.unwrap()
        XCTAssertEqual(value.0, "a")
        XCTAssertEqual(value.1, "b")
        XCTAssertEqual(value.2, "c")
        XCTAssertEqual(value.3, "d")
    }
    
    func test_sequential_fail_3() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d")
        let res = p.parse("a")
        XCTAssertTrue(try res.error().code == 1)
    }
    
    func test_sequential_success_4() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e")
        let res = p.parse("abcde")
        let value = try res.unwrap()
        XCTAssertEqual(value.0, "a")
        XCTAssertEqual(value.1, "b")
        XCTAssertEqual(value.2, "c")
        XCTAssertEqual(value.3, "d")
        XCTAssertEqual(value.4, "e")
    }
    
    func test_sequential_fail_4() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e")
        let res = p.parse("a")
        XCTAssertTrue(try res.error().code == 1)
    }
    
    func test_sequential_success_5() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f")
        let res = p.parse("abcdef")
        let value = try res.unwrap()
        XCTAssertEqual(value.0, "a")
        XCTAssertEqual(value.1, "b")
        XCTAssertEqual(value.2, "c")
        XCTAssertEqual(value.3, "d")
        XCTAssertEqual(value.4, "e")
        XCTAssertEqual(value.5, "f")
    }
    
    func test_sequential_fail_5() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f")
        let res = p.parse("a")
        XCTAssertTrue(try res.error().code == 1)
    }
    
    func test_sequential_success_6() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f") ~ char("g")
        let res = p.parse("abcdefg")
        let value = try res.unwrap()
        XCTAssertEqual(value.0, "a")
        XCTAssertEqual(value.1, "b")
        XCTAssertEqual(value.2, "c")
        XCTAssertEqual(value.3, "d")
        XCTAssertEqual(value.4, "e")
        XCTAssertEqual(value.5, "f")
        XCTAssertEqual(value.6, "g")
    }
    
    func test_sequential_fail_6() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f") ~ char("g")
        let res = p.parse("a")
        XCTAssertTrue(try res.error().code == 1)
    }
    
    func test_sequential_success_7() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f") ~ char("g") ~ char("h")
        let res = p.parse("abcdefgh")
        let value = try res.unwrap()
        XCTAssertEqual(value.0, "a")
        XCTAssertEqual(value.1, "b")
        XCTAssertEqual(value.2, "c")
        XCTAssertEqual(value.3, "d")
        XCTAssertEqual(value.4, "e")
        XCTAssertEqual(value.5, "f")
        XCTAssertEqual(value.6, "g")
        XCTAssertEqual(value.7, "h")
    }
    
    func test_sequential_fail_7() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f") ~ char("g") ~ char("h")
        let res = p.parse("a")
        XCTAssertTrue(try res.error().code == 1)
    }
    
    func test_sequential_success_8() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f") ~ char("g") ~ char("h") ~ char("i")
        let res = p.parse("abcdefghi")
        let value = try res.unwrap()
        XCTAssertEqual(value.0, "a")
        XCTAssertEqual(value.1, "b")
        XCTAssertEqual(value.2, "c")
        XCTAssertEqual(value.3, "d")
        XCTAssertEqual(value.4, "e")
        XCTAssertEqual(value.5, "f")
        XCTAssertEqual(value.6, "g")
        XCTAssertEqual(value.7, "h")
        XCTAssertEqual(value.8, "i")
    }
    
    func test_sequential_fail_8() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f") ~ char("g") ~ char("h") ~ char("i")
        let res = p.parse("a")
        XCTAssertTrue(try res.error().code == 1)
    }
    
    func test_sequential_success_9() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f") ~ char("g") ~ char("h") ~ char("i") ~ char("j")
        let res = p.parse("abcdefghij")
        let value = try res.unwrap()
        XCTAssertEqual(value.0, "a")
        XCTAssertEqual(value.1, "b")
        XCTAssertEqual(value.2, "c")
        XCTAssertEqual(value.3, "d")
        XCTAssertEqual(value.4, "e")
        XCTAssertEqual(value.5, "f")
        XCTAssertEqual(value.6, "g")
        XCTAssertEqual(value.7, "h")
        XCTAssertEqual(value.8, "i")
        XCTAssertEqual(value.9, "j")
    }
    
    func test_sequential_fail_9() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f") ~ char("g") ~ char("h") ~ char("i") ~ char("j")
        let res = p.parse("a")
        XCTAssertTrue(try res.error().code == 1)
    }
    
    func test_sequential_success_10() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f") ~ char("g") ~ char("h") ~ char("i") ~ char("j") ~ char("k")
        let res = p.parse("abcdefghijk")
        let value = try res.unwrap()
        XCTAssertEqual(value.0, "a")
        XCTAssertEqual(value.1, "b")
        XCTAssertEqual(value.2, "c")
        XCTAssertEqual(value.3, "d")
        XCTAssertEqual(value.4, "e")
        XCTAssertEqual(value.5, "f")
        XCTAssertEqual(value.6, "g")
        XCTAssertEqual(value.7, "h")
        XCTAssertEqual(value.8, "i")
        XCTAssertEqual(value.9, "j")
        XCTAssertEqual(value.10, "k")
    }
    
    func test_sequential_fail_10() throws {
        let p = char("a") ~ char("b") ~ char("c") ~ char("d") ~ char("e") ~ char("f") ~ char("g") ~ char("h") ~ char("i") ~ char("j") ~ char("k")
        let res = p.parse("a")
        XCTAssertTrue(try res.error().code == 1)
    }
    
}

#if os(Linux)
    extension Operators_SequentialTests {
        static var allTests : [(String, (Operators_SequentialTests) -> () throws -> Void)] {
            return [
                ("test_sequential_success_1", test_sequential_success_1),
                ("test_sequential_fail_1", test_sequential_fail_1),
                ("test_sequential_success_2", test_sequential_success_2),
                ("test_sequential_fail_2", test_sequential_fail_2),
                ("test_sequential_success_3", test_sequential_success_3),
                ("test_sequential_fail_3", test_sequential_fail_3),
                ("test_sequential_success_4", test_sequential_success_4),
                ("test_sequential_fail_4", test_sequential_fail_4),
                ("test_sequential_success_5", test_sequential_success_5),
                ("test_sequential_fail_5", test_sequential_fail_5),
                ("test_sequential_success_6", test_sequential_success_6),
                ("test_sequential_fail_6", test_sequential_fail_6),
                ("test_sequential_success_7", test_sequential_success_7),
                ("test_sequential_fail_7", test_sequential_fail_7),
                ("test_sequential_success_8", test_sequential_success_8),
                ("test_sequential_fail_8", test_sequential_fail_8),
                ("test_sequential_success_9", test_sequential_success_9),
                ("test_sequential_fail_9", test_sequential_fail_9),
                ("test_sequential_success_10", test_sequential_success_10),
                ("test_sequential_fail_10", test_sequential_fail_10)
            ]
        }
    }
#endif
