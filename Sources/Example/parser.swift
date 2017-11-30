//
//  parser.swift
//  parselPackageDescription
//
//  Created by Benjamin Herzog on 30.09.17.
//

import Parsel

public enum ParseError: Parsel.ParseError {
    case tokenMismatch(expected: Token, got: Token)
    case emptySequence
}

public enum AST {
    public enum Declaration {
        case constant, variable
        
        init(token: Token.Keyword) {
            switch token {
            case .val: self = .constant
            case .var: self = .variable
            }
        }
    }
    
    case declaration(Declaration, name: String, value: Token.Literal)
}

private let oneToken = Parser<[Token], Token> { input in
    guard let first = input.first else {
        return .fail(ParseError.emptySequence)
    }
    return .success(result: first, rest: Array(input.dropFirst()))
}

private func token(_ token: Token) -> Parser<[Token], Token> {
    return Parser { input in
        return oneToken.parse(input).flatMap { parsedToken, rest in
            guard parsedToken == token else {
                return .fail(ParseError.tokenMismatch(expected: token, got: parsedToken))
            }
            return .success(result: parsedToken, rest: rest)
        }
    }
}

private func parseKeyword(_ keyword: Token.Keyword) -> Parser<[Token], Token.Keyword> {
    return token(Token.keyword(keyword)) ^^ { _ in keyword }
}

private let identifier = Parser<[Token], String> { input in
    return oneToken.parse(input).flatMap { token, rest in
        if case let .identifier(name) = token {
            return .success(result: name, rest: rest)
        }
        return .fail(ParseError.tokenMismatch(expected: Token.identifier(name: "X"), got: token))
    }
}

private let literal = Parser<[Token], Token.Literal> { input in
    return oneToken.parse(input).flatMap { token, rest in
        if case let .literal(lit) = token {
            return .success(result: lit, rest: rest)
        }
        return .fail(ParseError.tokenMismatch(expected: Token.identifier(name: "X"), got: token))
    }
}

private func specificDeclaration(_ keyword: Token.Keyword) -> Parser<[Token], (Token.Keyword, String, Token.Literal)> {
    return parseKeyword(keyword) ~ identifier <~ token(.operate(.assign)) ~ literal
}

private let valDeclaration = specificDeclaration(.val)
private let varDeclaration = specificDeclaration(.var)
private let declaration = (valDeclaration | varDeclaration).map { info in
    return AST.declaration(AST.Declaration(token: info.0), name: info.1, value: info.2)
}

private let statement = declaration

let parser = statement.rep
