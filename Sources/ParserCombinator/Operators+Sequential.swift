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

public func ~<Token, A, B, C, D, E>(lhs: Parser<Token, (A, B, C, D)>, rhs: Parser<Token, E>) -> Parser<Token, (A, B, C, D, E)> {
    return Parser { tokens in
        switch lhs.parse(tokens) {
        case let .success((resultA, resultB, resultC, resultD), rest):
            return rhs.parse(rest).map(f: { (resultA, resultB, resultC, resultD, $0) })
        case let .fail(err):
            return .fail(err)
        }
    }
}

public func ~<Token, A, B, C, D, E, F>(lhs: Parser<Token, (A, B, C, D, E)>, rhs: Parser<Token, F>) -> Parser<Token, (A, B, C, D, E, F)> {
    return Parser { tokens in
        switch lhs.parse(tokens) {
        case let .success((resultA, resultB, resultC, resultD, resultE), rest):
            return rhs.parse(rest).map(f: { (resultA, resultB, resultC, resultD, resultE, $0) })
        case let .fail(err):
            return .fail(err)
        }
    }
}

public func ~<Token, A, B, C, D, E, F, G>(lhs: Parser<Token, (A, B, C, D, E, F)>, rhs: Parser<Token, G>) -> Parser<Token, (A, B, C, D, E, F, G)> {
    return Parser { tokens in
        switch lhs.parse(tokens) {
        case let .success((resultA, resultB, resultC, resultD, resultE, resultF), rest):
            return rhs.parse(rest).map(f: { (resultA, resultB, resultC, resultD, resultE, resultF, $0) })
        case let .fail(err):
            return .fail(err)
        }
    }
}

public func ~<Token, A, B, C, D, E, F, G, H>(lhs: Parser<Token, (A, B, C, D, E, F, G)>, rhs: Parser<Token, H>) -> Parser<Token, (A, B, C, D, E, F, G, H)> {
    return Parser { tokens in
        switch lhs.parse(tokens) {
        case let .success((resultA, resultB, resultC, resultD, resultE, resultF, resultG), rest):
            return rhs.parse(rest).map(f: { (resultA, resultB, resultC, resultD, resultE, resultF, resultG, $0) })
        case let .fail(err):
            return .fail(err)
        }
    }
}

public func ~<Token, A, B, C, D, E, F, G, H, I>(lhs: Parser<Token, (A, B, C, D, E, F, G, H)>, rhs: Parser<Token, I>) -> Parser<Token, (A, B, C, D, E, F, G, H, I)> {
    return Parser { tokens in
        switch lhs.parse(tokens) {
        case let .success((resultA, resultB, resultC, resultD, resultE, resultF, resultG, resultH), rest):
            return rhs.parse(rest).map(f: { (resultA, resultB, resultC, resultD, resultE, resultF, resultG, resultH, $0) })
        case let .fail(err):
            return .fail(err)
        }
    }
}

public func ~<Token, A, B, C, D, E, F, G, H, I, J>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I)>, rhs: Parser<Token, J>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J)> {
    return Parser { tokens in
        switch lhs.parse(tokens) {
        case let .success((resultA, resultB, resultC, resultD, resultE, resultF, resultG, resultH, resultI), rest):
            return rhs.parse(rest).map(f: { (resultA, resultB, resultC, resultD, resultE, resultF, resultG, resultH, resultI, $0) })
        case let .fail(err):
            return .fail(err)
        }
    }
}

public func ~<Token, A, B, C, D, E, F, G, H, I, J, K>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J)>, rhs: Parser<Token, K>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K)> {
    return Parser { tokens in
        switch lhs.parse(tokens) {
        case let .success((resultA, resultB, resultC, resultD, resultE, resultF, resultG, resultH, resultI, resultJ), rest):
            return rhs.parse(rest).map(f: { (resultA, resultB, resultC, resultD, resultE, resultF, resultG, resultH, resultI, resultJ, $0) })
        case let .fail(err):
            return .fail(err)
        }
    }
}
