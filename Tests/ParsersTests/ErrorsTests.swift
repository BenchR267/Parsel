//
//  ErrorsTests.swift
//  ParsersTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import Parsers

class ErrorsTests: XCTestCase {

    func test_code() {
        var err = Errors.unwrappedFailedResult
        XCTAssertEqual(err.code, 0)
        
        err = .errorFromSuccessfulResult
        XCTAssertEqual(err.code, 1)
    }

}
