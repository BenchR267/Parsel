//
//  LinuxMain.swift
//  ParserCombinatorTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import ParserCombinatorTests

#if os(Linux)
XCTMain([
	testCase(ParserCombinator_TestCase.allTests),
    testCase(ErrorsTests.allTests),
    testCase(OperatorsTests.allTests),
    testCase(ParseResultTests.allTests),
    testCase(Parser_ConjunctionTests.allTests),
    testCase(Operators_SequentialTests.allTests),
    testCase(ParserTests.allTests),
    ])
#endif
