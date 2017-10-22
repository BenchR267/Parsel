//
//  LinuxMain.swift
//  ParselTests
//
//  Created by Benjamin Herzog on 13.08.17.
//

import XCTest
@testable import parselTests

#if os(Linux)
XCTMain([
    testCase(Errors_TestCase.allTests),
    testCase(Lexical_TestCase.allTests),
    testCase(Operators_Sequential_TestCase.allTests),
    testCase(Operators_TestCase.allTests),
	testCase(Parsel_TestCase.allTests),
    testCase(ParseResult_TestCase.allTests),
    testCase(Parser_Conjunction_TestCase.allTests),
    testCase(Parser_TestCase.allTests),
    testCase(RegexParser_TestCase.allTests),
    ])
#endif
