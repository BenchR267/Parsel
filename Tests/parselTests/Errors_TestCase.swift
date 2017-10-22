//
//  ErrorsTests.swift
//  ParselTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import parsel

class Errors_TestCase: XCTestCase {
    
    func test_genericError() {
        let message = "a message"
        let err1 = GenericParseError(message: message)
        XCTAssertEqual(err1.message, message)
    }

}

#if os(Linux)
    extension Errors_TestCase {
        static var allTests = [
            ("test_genericError", test_genericError),
        ]
    }
#endif
