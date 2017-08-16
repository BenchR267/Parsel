//
//  RegexParserTests.swift
//  ParserCombinatorTests
//
//  Created by Benjamin Herzog on 14.08.17.
//

import XCTest
@testable import ParserCombinator

class RegexParserTests: XCTestCase {

    func test_init() {
        let regex = "a"
        let parser = RegexParser(regex)
        XCTAssertEqual(parser.regex, regex)
    }
    
    func test_init_stringLiteral() {
        let parser = "a".r
        XCTAssertEqual(parser.regex, "a")
    }
    
    func test_parse_number() throws {
        let parser = RegexParser("[0-9]+") ^^ { r in Int(r)! }
        let result = parser.parse("1234")
        XCTAssertEqual(try result.unwrap(), 1234)
        
        XCTAssertFalse(parser.parse("abc").isSuccess())
    }
    
    func test_parse_lowercasedLetters() throws {
        let parser = RegexParser("[a-z]+")
        let result = parser.parse("abc")
        XCTAssertEqual(try result.unwrap(), "abc")
        
        XCTAssertFalse(parser.parse("1234").isSuccess())
    }
    
    func test_parse_fail() throws {
        let parser = "[0-9]".r
        let result = parser.parse("a")
        XCTAssertTrue(result.isFailed())
        let error = try result.error() as! RegexParser.Error
        guard case let .doesNotMatch(pattern, input) = error else {
            return XCTFail("Wrong error returned. Expected to get doesNotMatch, got \(error)")
        }
        XCTAssertEqual(pattern, parser.regex)
        XCTAssertEqual(input, "a")
    }
    
    func test_parse_fail_invalidRegex() throws {
        let parser = "[".r
        let result = parser.parse("abc")
        let error = try result.error() as! RegexParser.Error
        guard case let .invalidRegex(regex) = error else {
            return XCTFail("Entered invalid regex, but got \(error) instead.")
        }
        XCTAssertEqual(regex, "[")
    }
    
    func test_error() {
        XCTAssertEqual(RegexParser.Error.doesNotMatch(pattern: "", input: "").code, 0)
        XCTAssertEqual(RegexParser.Error.unimplemented.code, 1)
        XCTAssertEqual(RegexParser.Error.invalidRegex("").code, 2)
    }
    
}

#if os(Linux)
    extension RegexParserTests {
        static var allTests : [(String, (RegexParserTests) -> () throws -> Void)] {
            return [
                ("test_init", test_init),
                ("test_init_stringLiteral", test_init_stringLiteral),
                ("test_parse_number", test_parse_number),
                ("test_parse_lowercasedLetters", test_parse_lowercasedLetters),
                ("test_parse_fail", test_parse_fail),
//                ("test_parse_fail_invalidRegex", test_parse_fail_invalidRegex), // deactivated until https://bugs.swift.org/browse/SR-5477 is fixed
                ("test_error", test_error),
            ]
        }
    }
#endif
