//
//  Lexical_TestCase.swift
//  ParselTests
//
//  Created by Benjamin Herzog on 21.08.17.
//

import XCTest
@testable import parsel

class Lexical_TestCase: XCTestCase {
    
    func test_char() throws {
        let p = L.char
        
        let res1 = p.parse("ab")
        XCTAssertEqual(try res1.unwrap(), "a")
        XCTAssertEqual(try res1.rest(), "b")
        
        let res2 = p.parse("")
        guard case let .unexpectedToken(expected, got) = try res2.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "char")
        XCTAssertEqual(got, "")
    }
    
    func test_char_condition() throws {
        let p = L.char { L.asciiValue(from: $0) >= L.asciiValue(from: "a") }
        
        let res1 = p.parse("ABC")
        guard case let .unexpectedToken(expected, got)? = try res1.error() as? L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "certain char")
        XCTAssertEqual(got, "A")
        
        let res2 = p.parse("abc")
        XCTAssertEqual(try res2.unwrap(), "a")
        XCTAssertEqual(try res2.rest(), "bc")
    }
    
    func test_char_specific() throws {
        let p = L.char("a")
        
        let res1 = p.parse("ab")
        XCTAssertEqual(try res1.unwrap(), "a")
        XCTAssertEqual(try res1.rest(), "b")

        let res2 = p.parse("ba")
        guard case let .unexpectedToken(expected, got) = try res2.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "a")
        XCTAssertEqual(got, "b")

        let res3 = p.parse("")
        guard case let .unexpectedToken(expected2, got2) = try res3.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected2, "a")
        XCTAssertEqual(got2, "")
    }
    
    func test_string() throws {
        let p = L.string("abc")
        
        let res1 = p.parse("abcde")
        XCTAssertEqual(try res1.unwrap(), "abc")
        XCTAssertEqual(try res1.rest(), "de")
        
        let res2 = p.parse("edcba")
        guard case let .unexpectedToken(expected, got) = try res2.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "abc")
        XCTAssertEqual(got, "edc")
    }
    
    func test_string_length() throws {
        let p = L.string(length: 3)
        
        let res1 = p.parse("aaaaa")
        XCTAssertEqual(try res1.unwrap(), "aaa")
        XCTAssertEqual(try res1.rest(), "aa")
        
        let res2 = p.parse("aa")
        guard case let .unexpectedToken(expected, got) = try res2.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "char")
        XCTAssertEqual(got, "")
    }
    
    func test_digit() throws {
        let p = L.digit
        
        let res1 = p.parse("1a")
        XCTAssertEqual(try res1.unwrap(), 1)
        XCTAssertEqual(try res1.rest(), "a")
        
        let res2 = p.parse("a1")
        guard case let .unexpectedToken(expected, got) = try res2.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "digit")
        XCTAssertEqual(got, "a")
    }
    
    func test_binaryDigit() throws {
        let p = L.binaryDigit
        
        let res1 = p.parse("11a")
        XCTAssertEqual(try res1.unwrap(), 1)
        XCTAssertEqual(try res1.rest(), "1a")
        
        let res2 = p.parse("2")
        guard case let .unexpectedToken(expected, got) = try res2.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "0 or 1")
        XCTAssertEqual(got, "2")
    }
    
    func test_binaryNumber() throws {
        let p = L.binaryNumber
        
        let res1 = p.parse("0b10110110a")
        XCTAssertEqual(try res1.unwrap(), 182)
        XCTAssertEqual(try res1.rest(), "a")
        
        let res2 = p.parse("0xAF3410")
        guard case let .unexpectedToken(expected, got) = try res2.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "0b")
        XCTAssertEqual(got, "0x")
        
        let res3 = p.parse("0b2")
        guard case let .unexpectedToken(expected2, got2) = try res3.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected2, "0 or 1")
        XCTAssertEqual(got2, "2")
    }
    
    func test_octalDigit() throws {
        let p = L.octalDigit
        
        let res1 = p.parse("77a")
        XCTAssertEqual(try res1.unwrap(), 7)
        XCTAssertEqual(try res1.rest(), "7a")
        
        let res2 = p.parse("8")
        guard case let .unexpectedToken(expected, got) = try res2.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "0 to 7")
        XCTAssertEqual(got, "8")
    }
    
    func test_octalNumber() throws {
        let p = L.octalNumber
        
        let res1 = p.parse("0o12372106a")
        XCTAssertEqual(try res1.unwrap(), 2749510)
        XCTAssertEqual(try res1.rest(), "a")
        
        let res2 = p.parse("0xAF3410")
        guard case let .unexpectedToken(expected, got) = try res2.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "0o")
        XCTAssertEqual(got, "0x")
        
        let res3 = p.parse("0o8")
        guard case let .unexpectedToken(expected2, got2) = try res3.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected2, "0 to 7")
        XCTAssertEqual(got2, "8")
    }
    
    func test_hexadecimalDigit() throws {
        let p = L.hexadecimalDigit
        
        let res1 = p.parse("a7a")
        XCTAssertEqual(try res1.unwrap(), 10)
        XCTAssertEqual(try res1.rest(), "7a")
        
        let res2 = p.parse("A7A")
        XCTAssertEqual(try res2.unwrap(), 10)
        XCTAssertEqual(try res2.rest(), "7A")
        
        let res3 = p.parse("F7F")
        XCTAssertEqual(try res3.unwrap(), 15)
        XCTAssertEqual(try res3.rest(), "7F")
        
        let res4 = p.parse("f7f")
        XCTAssertEqual(try res4.unwrap(), 15)
        XCTAssertEqual(try res4.rest(), "7f")
        
        let res5 = p.parse("g")
        guard case let .unexpectedToken(expected, got) = try res5.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "0 to 15")
        XCTAssertEqual(got, "-1")
        
        let res6 = p.parse(",")
        guard case let .unexpectedToken(expected2, got2) = try res6.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected2, "0 to 15")
        XCTAssertEqual(got2, "-1")
        
        let res7 = p.parse("")
        guard case let .unexpectedToken(expected3, got3) = try res7.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected3, "char")
        XCTAssertEqual(got3, "")
    }
    
    func test_hexadecimalNumber() throws {
        let p = L.hexadecimalNumber
        
        let res1 = p.parse("0xdeadg")
        XCTAssertEqual(try res1.unwrap(), 57005)
        XCTAssertEqual(try res1.rest(), "g")
        
        let res2 = p.parse("0xDEADG")
        XCTAssertEqual(try res2.unwrap(), 57005)
        XCTAssertEqual(try res2.rest(), "G")
        
        let res3 = p.parse("0x12345G")
        XCTAssertEqual(try res3.unwrap(), 74565)
        XCTAssertEqual(try res3.rest(), "G")
        
        let res4 = p.parse("0bAF3410")
        guard case let .unexpectedToken(expected, got) = try res4.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "0X")
        XCTAssertEqual(got, "0b")
        
        let res5 = p.parse("0xg")
        guard case let .unexpectedToken(expected2, got2) = try res5.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected2, "0 to 15")
        XCTAssertEqual(got2, "-1")
    }
    
    func test_decimalNumber() throws {
        let p = L.decimalNumber
        
        let res1 = p.parse("1234a")
        XCTAssertEqual(try res1.unwrap(), 1234)
        XCTAssertEqual(try res1.rest(), "a")
        
        let res2 = p.parse("abcde")
        guard case let .unexpectedToken(expected, got) = try res2.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "digit")
        XCTAssertEqual(got, "a")
    }
    
    func test_number() {
        let p = L.number
        
        func test(input: String, result: Int, rest: String) {
            let res = p.parse(input)
            XCTAssertEqual(try res.unwrap(), result)
            XCTAssertEqual(try res.rest(), rest)
        }
        
        test(input: "1234a", result: 1234, rest: "a")
        test(input: "9a", result: 9, rest: "a")
        test(input: "0x12345", result: 74565, rest: "")
        test(input: "0b101011b", result: 43, rest: "b")
        test(input: "0o342424", result: 115988, rest: "")
    }
    
    func test_floatingNumber() throws {
        let p = L.floatingNumber
        
        let res1 = p.parse("0,123a")
        XCTAssertEqual(try res1.unwrap(), 0.123, accuracy: 0.0001)
        XCTAssertEqual(try res1.rest(), "a")
        
        let res2 = p.parse("0.123a")
        XCTAssertEqual(try res2.unwrap(), 0.123, accuracy: 0.0001)
        XCTAssertEqual(try res2.rest(), "a")
    }
    
    func test_oneWhitespace() throws {
        let p = L.oneWhitespace
        
        let res1 = p.parse(" a")
        XCTAssertEqual(try res1.unwrap(), " ")
        XCTAssertEqual(try res1.rest(), "a")
        
        let res2 = p.parse("a ")
        guard case let .unexpectedToken(expected, got) = try res2.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "\t")
        XCTAssertEqual(got, "a")
    }
    
    func test_whitespaces() throws {
        let p = L.whitespaces ^^ { String($0) }
        
        let res1 = p.parse("   \t\n\r\na")
        XCTAssertEqual(try res1.unwrap(), "   \t\n\r\n")
        XCTAssertEqual(try res1.rest(), "a")
        
        let res2 = p.parse("a ")
        guard case let .unexpectedToken(expected, got) = try res2.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "\t")
        XCTAssertEqual(got, "a")
    }
    
    func test_asciiChar() throws {
        let p = L.asciiChar
        
        let res1 = p.parse("a")
        XCTAssertEqual(try res1.unwrap(), "a")
        XCTAssertEqual(try res1.rest(), "")
        
        let res2 = p.parse("😜")
        guard case let .unexpectedToken(expected, got) = try res2.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "ascii")
        XCTAssertEqual(got, "😜")
    }
    
    func test_asciiString() throws {
        let p = L.asciiString
        
        let res1 = p.parse("abc😜")
        XCTAssertEqual(try res1.unwrap(), "abc")
        XCTAssertEqual(try res1.rest(), "😜")
        
        let res2 = p.parse("😜abc")
        guard case let .unexpectedToken(expected, got) = try res2.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "ascii")
        XCTAssertEqual(got, "😜")
    }
    
    func test_lowercaseLetter() throws {
        let p = L.lowercaseLetter
        
        let res1 = p.parse("abB")
        XCTAssertEqual(try res1.unwrap(), "a")
        XCTAssertEqual(try res1.rest(), "bB")
        
        let res2 = p.parse("Ab")
        guard case let .unexpectedToken(expected, got) = try res2.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "lowercase")
        XCTAssertEqual(got, "A")
    }
    
    func test_uppercaseLetter() throws {
        let p = L.uppercaseLetter
        
        let res1 = p.parse("ABb")
        XCTAssertEqual(try res1.unwrap(), "A")
        XCTAssertEqual(try res1.rest(), "Bb")
        
        let res2 = p.parse("aB")
        guard case let .unexpectedToken(expected, got) = try res2.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "uppercase")
        XCTAssertEqual(got, "a")
    }
    
    func test_letter() throws {
        let p = L.letter
        
        let res1 = p.parse("ab1")
        XCTAssertEqual(try res1.unwrap(), "a")
        XCTAssertEqual(try res1.rest(), "b1")
        
        let res2 = p.parse("1aB")
        guard case let .unexpectedToken(expected, got) = try res2.error() as! L.Error else {
            return XCTFail()
        }
        XCTAssertEqual(expected, "letter")
        XCTAssertEqual(got, "1")
    }
    
    func test_asciiValue() {
        XCTAssertEqual(L.asciiValue(from: Character("😜")), -1)
        XCTAssertEqual(L.asciiValue(from: Character("a")), 97)
    }

    func test_error_description() {
        XCTAssertEqual(L.Error.unexpectedToken(expected: "EXP", got: "GOT").description, "Parsing Error: Expected EXP but got GOT.")
    }
}

#if os(Linux)
    extension Lexical_TestCase {
        static var allTests = [
            ("test_char", test_char),
            ("test_char_condition", test_char_condition),
            ("test_char_specific", test_char_specific),
            ("test_string", test_string),
            ("test_string_length", test_string_length),
            ("test_digit", test_digit),
            ("test_binaryDigit", test_binaryDigit),
            ("test_binaryNumber", test_binaryNumber),
            ("test_octalDigit", test_octalDigit),
            ("test_octalNumber", test_octalNumber),
            ("test_hexadecimalDigit", test_hexadecimalDigit),
            ("test_hexadecimalNumber", test_hexadecimalNumber),
            ("test_decimalNumber", test_decimalNumber),
            ("test_number", test_number),
            ("test_floatingNumber", test_floatingNumber),
            ("test_oneWhitespace", test_oneWhitespace),
            ("test_whitespaces", test_whitespaces),
            ("test_asciiChar", test_asciiChar),
            ("test_asciiString", test_asciiString),
            ("test_lowercaseLetter", test_lowercaseLetter),
            ("test_uppercaseLetter", test_uppercaseLetter),
            ("test_letter", test_letter),
            ("test_asciiValue", test_asciiValue),
            ("test_error_description", test_error_description)
        ]
    }
#endif
