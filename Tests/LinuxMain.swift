//
//  LinuxMain.swift
//  ParselTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import ParselTests

#if os(Linux)
XCTMain([
	testCase(ParserCombinator_TestCase.allTests),
    testCase(ErrorsTests.allTests),
    testCase(OperatorsTests.allTests),
    testCase(ParseResultTests.allTests),
    testCase(Parser_ConjunctionTests.allTests),
    testCase(Operators_SequentialTests.allTests),
    testCase(ParserTests.allTests),
    testCase(RegexParserTests.allTests),
    ])
#endif
