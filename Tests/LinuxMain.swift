//
//  LinuxMain.swift
//  ParsersTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import ParsersTests

#if os(Linux)
XCTMain([
    testCase(ErrorsTests.allTests),
    testCase(OperatorsTests.allTests),
    testCase(ParseResultTests.allTests),
    testCase(Parser_ConjunctionTests.allTests),
    testCase(ParserTests.allTests),
    ])
#endif
