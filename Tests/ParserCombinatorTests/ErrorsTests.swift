//
//  ErrorsTests.swift
//  ParserCombinatorTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import ParserCombinator

class ErrorsTests: XCTestCase {

    func test_code() {
        var err = Errors.unwrappedFailedResult
        XCTAssertEqual(err.code, 0)
        
        err = .errorFromSuccessfulResult
        XCTAssertEqual(err.code, 1)
    }

}

#if os(Linux)
    extension ErrorsTests {
        static var allTests : [(String, (ErrorsTests) -> () throws -> Void)] {
            return [
                ("test_code", test_code),
            ]
        }
    }
#endif
