//
//  lexer.swift
//  parselPackageDescription
//
//  Created by Benjamin Herzog on 30.09.17.
//

import Parsel

public enum Token {
    public enum Literal {
        case int(Int)
        case string(String)
    }
    public enum Operator {
        case plus, minus, equal, assign
    }
    public enum Keyword {
        case val, `var`
    }
    
    case literal(Literal)
    case operate(Operator)
    case keyword(Keyword)
    case identifier(name: String)
}

private let intLiteral = L.number ^^ { Token.literal(.int($0)) }
private let stringLiteral = L.char("\"") ~> L.char(condition: { $0 != "\"" }).rep <~ L.char("\"") ^^ { chars in
    return Token.literal(.string(String.init(chars)))
}
private let literal = intLiteral | stringLiteral

private let plusOperator = L.plus.typeErased ^^ { Token.operate(.plus) }
private let minusOperator = L.minus.typeErased ^^ { Token.operate(.minus) }
private let equalOperator = L.equal.typeErased ^^ { Token.operate(.equal) }
private let assignOperator = L.assign.typeErased ^^ { Token.operate(.assign) }
private let `operator` = Parser.or([plusOperator, minusOperator, equalOperator, assignOperator])

private let val = L.string("val").typeErased ^^ { Token.keyword(.val) }
private let `var` = L.string("var").typeErased ^^ { Token.keyword(.var) }
private let keyword = Parser.or([val, `var`])

private let digitAsString = L.digit ^^ { String($0) }
private let letterAsString = L.letter ^^ { String($0) }
private let identifier = letterAsString ~ (letterAsString | digitAsString).rep ^^ {
    return Token.identifier(name: $0.0 + $0.1.joined())
}

public let lexer = Parser.or([keyword, literal, `operator`, identifier]).rep(sep: L.oneWhitespace)

extension Token.Literal: Equatable {
    public static func == (lhs: Token.Literal, rhs: Token.Literal) -> Bool {
        switch (lhs, rhs) {
        case let (.int(l), .int(r)): return l == r
        case let (.string(l), .string(r)): return l == r
        default: return false
        }
    }
}

extension Token: Equatable {
    public static func == (lhs: Token, rhs: Token) -> Bool {
        switch (lhs, rhs) {
        case let (.literal(l), .literal(r)): return l == r
        case let (.operate(l), .operate(r)): return l == r
        case let (.keyword(l), .keyword(r)): return l == r
        case let (.identifier(l), .identifier(r)): return l == r
        default: return false
        }
    }
}
