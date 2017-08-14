//
//  Operators+SequentialTests.swift
//  ParsersTests
//
//  Created by Benjamin Herzog on 14.08.17.
//

import XCTest
@testable import Parsers

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
                ("test_sequential_fail_3", test_sequential_fail_3)
            ]
        }
    }
#endif
