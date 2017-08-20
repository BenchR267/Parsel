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
        
        err = .conjunctionOfEmptyCollection
        XCTAssertEqual(err.code, 2)
        
        err = .expectedAtLeastOnce
        XCTAssertEqual(err.code, 3)
    }
    
    func test_genericError() {
        let message = "a message"
        let err1 = GenericParseError(message: message)
        XCTAssertEqual(err1.message, message)
        XCTAssertEqual(err1.code, UInt64(abs(message.hashValue)))
    }

}

#if os(Linux)
    extension ErrorsTests {
        static var allTests = [
            ("test_code", test_code),
            ("test_genericError", test_genericError),
        ]
    }
#endif
