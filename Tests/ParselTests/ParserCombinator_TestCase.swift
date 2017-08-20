//
//  Parsel_TestCase.swift
//  ParselTests
//
//  Created by Benjamin Herzog on 14.08.17.
//

import XCTest
@testable import Parsel

class Parsel_TestCase: XCTestCase {

    func test_addition() {
        
        let addition = (number ~ char("+") ~ number).map { a, _, b in
            return a + b
        }
        
        let res = addition.parse("1234+56")
        XCTAssertEqual(1290, try res.unwrap())
    }
    
    func test_readme_code() throws {
        
        let digit = Parser<String, Int> { str in
            guard let first = str.characters.first, let number = Int(String(first)) else {
                return .fail(TestError(1))
            }
            return .success(result: number, rest: String(str.dropFirst()))
        }
        
        func char(_ c: Character) -> Parser<String, Character> {
            return Parser { str in
                guard let first = str.characters.first, first == c else {
                    return .fail(TestError(1))
                }
                return .success(result: first, rest: String(str.dropFirst()))
            }
        }
        
        let addition1 = (digit ~ char("+") ~ digit).map { a, _, b in
            return a + b
        }
        let result1 = addition1.parse("2+4")
        
        XCTAssertEqual(try result1.unwrap(), 6)
        
        func intFromDigits(_ digits: [Int]) -> Int {
            return digits.reduce(0) { res, e in
                return res * 10 + e
            }
        }
        
        let number = digit.rep.map(intFromDigits)
        let addition2 = (number ~ char("+") ~ number).map { a, _, b in
            return a + b
        }
        
        let result2 = addition2.parse("123+456")
        XCTAssertEqual(try result2.unwrap(), 579)
    }

}

#if os(Linux)
    extension Parsel_TestCase {
        static var allTests = [
            ("test_addition", test_addition),
            ("test_readme_code", test_readme_code)
        ]
    }
#endif
