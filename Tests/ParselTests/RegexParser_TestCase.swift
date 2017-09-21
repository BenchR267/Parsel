//
//  RegexParserTests.swift
//  ParselTests
//
//  Created by Benjamin Herzog on 14.08.17.
//

import XCTest
@testable import parsel

class RegexParser_TestCase: XCTestCase {

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
    
    func test_parse_mail() throws {
        let p = R.mail
        let res1 = p.parse("mail@benchr.de")
        XCTAssertEqual(try res1.unwrap(), "mail@benchr.de")
        
        let res2 = p.parse("mail@mail@benchr.de")
        XCTAssertTrue(res2.isFailed())
    }
    
    func test_parse_httpAddress() throws {
        let p = R.httpAddress
        let res1 = p.parse("https://www.google.de")
        XCTAssertEqual(try res1.unwrap(), "https://www.google.de")
        
        let res2 = p.parse("http://https://facebook.com")
        XCTAssertTrue(res2.isFailed())
    }
    
    func test_parse_ipAddress() throws {
        let p = R.ipAddress
        let res1 = p.parse("192.168.2.1")
        XCTAssertEqual(try res1.unwrap(), "192.168.2.1")
        
        let res2 = p.parse("5454.242.545.1")
        XCTAssertTrue(res2.isFailed())
    }
    
    func test_parse_semver() throws {
        let p = R.semver
        
        let tests = [
            "1.0.0",
            "1.0.0-alpha1",
            "1.0.0+build-123",
            "v1.0.0",
            "1.0.0b",
            "1.0.0+build-abc."
        ]
        
        for test in tests {
            let res1 = p.parse(test)
            XCTAssertTrue(test.hasPrefix(try res1.unwrap()))
        }
        
        let failTests = [
            "a.b.c",
            "1",
            "1.0"
        ]
        
        for test in failTests {
            let res2 = p.parse(test)
            XCTAssertTrue(res2.isFailed())
        }
    }
    
}

#if os(Linux)
    extension RegexParser_TestCase {
        static var allTests = [
            ("test_init", test_init),
            ("test_init_stringLiteral", test_init_stringLiteral),
            ("test_parse_number", test_parse_number),
            ("test_parse_lowercasedLetters", test_parse_lowercasedLetters),
            ("test_parse_fail", test_parse_fail),
            ("test_parse_fail_invalidRegex", test_parse_fail_invalidRegex),
            ("test_parse_mail", test_parse_mail),
            ("test_parse_httpAddress", test_parse_httpAddress),
            ("test_parse_ipAddress", test_parse_ipAddress),
            ("test_parse_semver", test_parse_semver)
        ]
    }
#endif
