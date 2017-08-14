// This file is generated via scripts/SequentialOperators.swift. Do not modify manually!

public func ~<Token, A, B>(lhs: Parser<Token, (A)>, rhs: Parser<Token, B>) -> Parser<Token, (A, B)> {
    return Parser { tokens in
        switch lhs.parse(tokens) {
        case let .success((resultA), rest):
            return rhs.parse(rest).map(f: { (resultA, $0) })
        case let .fail(err):
            return .fail(err)
        }
    }
}

public func ~<Token, A, B, C>(lhs: Parser<Token, (A, B)>, rhs: Parser<Token, C>) -> Parser<Token, (A, B, C)> {
    return Parser { tokens in
        switch lhs.parse(tokens) {
        case let .success((resultA, resultB), rest):
            return rhs.parse(rest).map(f: { (resultA, resultB, $0) })
        case let .fail(err):
            return .fail(err)
        }
    }
}

public func ~<Token, A, B, C, D>(lhs: Parser<Token, (A, B, C)>, rhs: Parser<Token, D>) -> Parser<Token, (A, B, C, D)> {
    return Parser { tokens in
        switch lhs.parse(tokens) {
        case let .success((resultA, resultB, resultC), rest):
            return rhs.parse(rest).map(f: { (resultA, resultB, resultC, $0) })
        case let .fail(err):
            return .fail(err)
        }
    }
}
