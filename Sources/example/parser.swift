//
//  parser.swift
//  parselPackageDescription
//
//  Created by Benjamin Herzog on 30.09.17.
//

import parsel

public enum ParseError: parsel.ParseError {
    case tokenMismatch(expected: Token, got: Token)
    case emptySequence
}

public enum AST {
    public enum Declaration {
        case val, `var`
    }
    
    case declaration(Declaration)
}

private let oneToken = Parser<[Token], Token> { input in
    guard let first = input.first else {
        return .fail(ParseError.emptySequence)
    }
    return .success(result: first, rest: Array(input.dropFirst()))
}

private func token(_ token: Token) -> Parser<[Token], Token> {
    return Parser { input in
        return oneToken.parse(input).flatMap { t, r in
            guard t == token else {
                return .fail(ParseError.tokenMismatch(expected: token, got: t))
            }
            return .success(result: t, rest: r)
        }
    }
}

private let identifier = Parser<[Token], String> { input in
    return oneToken.parse(input).flatMap { t, r in
        if case let .identifier(name) = t {
            return .success(result: name, rest: r)
        }
        return .fail(ParseError.tokenMismatch(expected: Token.identifier(name: "X"), got: t))
    }
}

private let literal = Parser<[Token], Token.Literal> { input in
    return oneToken.parse(input).flatMap { t, r in
        if case let .literal(lit) = t {
            return .success(result: lit, rest: r)
        }
        return .fail(ParseError.tokenMismatch(expected: Token.identifier(name: "X"), got: t))
    }
}

private func specificDeclaration(_ keyword: Token.Keyword) -> Parser<[Token], (String, Token.Literal)> {
    return token(.keyword(keyword)) ~> identifier <~ token(.op(.assign)) ~ literal
}

private let valDeclaration = specificDeclaration(.val)
private let varDeclaration = specificDeclaration(.var)
let declaration = valDeclaration | varDeclaration

