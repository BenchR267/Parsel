// This file is generated via scripts/SequentialOperators.swift. Do not modify manually!

public func >~<Token, A, B>(lhs: Parser<Token, A>, rhs: @escaping @autoclosure () -> Parser<Token, B>) -> Parser<Token, B> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { _, rest in
            return rhs().parse(rest)
        })
    }
}

public func <~<Token, A, B>(lhs: Parser<Token, B>, rhs: @escaping @autoclosure () -> Parser<Token, A>) -> Parser<Token, B> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { result, rest in
            return rhs().parse(rest).map(f: { _, _ in
                return result
            })
        })
    }
}

public func ~<Token, A, B>(lhs: Parser<Token, (A)>, rhs: @escaping @autoclosure () -> Parser<Token, B>) -> Parser<Token, (A, B)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (result, rest) in
            return rhs().parse(rest).map(f: { r, t in (result, r) })
        })
    }
}
    

public func ~<Token, A, B, C>(lhs: Parser<Token, (A, B)>, rhs: @escaping @autoclosure () -> Parser<Token, C>) -> Parser<Token, (A, B, C)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (result, rest) in
            return rhs().parse(rest).map(f: { r, t in (result.0, result.1, r) })
        })
    }
}
            
public func ~<Token, A, B, C>(lhs: Parser<Token, C>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B)>) -> Parser<Token, (C, A, B)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (r, rest) in
            return rhs().parse(rest).map(f: { result, t in (r, result.0, result.1) })
        })
    }
}

public func ~<Token, A, B, C, D>(lhs: Parser<Token, (A, B, C)>, rhs: @escaping @autoclosure () -> Parser<Token, D>) -> Parser<Token, (A, B, C, D)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (result, rest) in
            return rhs().parse(rest).map(f: { r, t in (result.0, result.1, result.2, r) })
        })
    }
}
            
public func ~<Token, A, B, C, D>(lhs: Parser<Token, D>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C)>) -> Parser<Token, (D, A, B, C)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (r, rest) in
            return rhs().parse(rest).map(f: { result, t in (r, result.0, result.1, result.2) })
        })
    }
}

public func ~<Token, A, B, C, D, E>(lhs: Parser<Token, (A, B, C, D)>, rhs: @escaping @autoclosure () -> Parser<Token, E>) -> Parser<Token, (A, B, C, D, E)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (result, rest) in
            return rhs().parse(rest).map(f: { r, t in (result.0, result.1, result.2, result.3, r) })
        })
    }
}
            
public func ~<Token, A, B, C, D, E>(lhs: Parser<Token, E>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D)>) -> Parser<Token, (E, A, B, C, D)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (r, rest) in
            return rhs().parse(rest).map(f: { result, t in (r, result.0, result.1, result.2, result.3) })
        })
    }
}

public func ~<Token, A, B, C, D, E, F>(lhs: Parser<Token, (A, B, C, D, E)>, rhs: @escaping @autoclosure () -> Parser<Token, F>) -> Parser<Token, (A, B, C, D, E, F)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (result, rest) in
            return rhs().parse(rest).map(f: { r, t in (result.0, result.1, result.2, result.3, result.4, r) })
        })
    }
}
            
public func ~<Token, A, B, C, D, E, F>(lhs: Parser<Token, F>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E)>) -> Parser<Token, (F, A, B, C, D, E)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (r, rest) in
            return rhs().parse(rest).map(f: { result, t in (r, result.0, result.1, result.2, result.3, result.4) })
        })
    }
}

public func ~<Token, A, B, C, D, E, F, G>(lhs: Parser<Token, (A, B, C, D, E, F)>, rhs: @escaping @autoclosure () -> Parser<Token, G>) -> Parser<Token, (A, B, C, D, E, F, G)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (result, rest) in
            return rhs().parse(rest).map(f: { r, t in (result.0, result.1, result.2, result.3, result.4, result.5, r) })
        })
    }
}
            
public func ~<Token, A, B, C, D, E, F, G>(lhs: Parser<Token, G>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F)>) -> Parser<Token, (G, A, B, C, D, E, F)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (r, rest) in
            return rhs().parse(rest).map(f: { result, t in (r, result.0, result.1, result.2, result.3, result.4, result.5) })
        })
    }
}

public func ~<Token, A, B, C, D, E, F, G, H>(lhs: Parser<Token, (A, B, C, D, E, F, G)>, rhs: @escaping @autoclosure () -> Parser<Token, H>) -> Parser<Token, (A, B, C, D, E, F, G, H)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (result, rest) in
            return rhs().parse(rest).map(f: { r, t in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, r) })
        })
    }
}
            
public func ~<Token, A, B, C, D, E, F, G, H>(lhs: Parser<Token, H>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G)>) -> Parser<Token, (H, A, B, C, D, E, F, G)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (r, rest) in
            return rhs().parse(rest).map(f: { result, t in (r, result.0, result.1, result.2, result.3, result.4, result.5, result.6) })
        })
    }
}

public func ~<Token, A, B, C, D, E, F, G, H, I>(lhs: Parser<Token, (A, B, C, D, E, F, G, H)>, rhs: @escaping @autoclosure () -> Parser<Token, I>) -> Parser<Token, (A, B, C, D, E, F, G, H, I)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (result, rest) in
            return rhs().parse(rest).map(f: { r, t in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, r) })
        })
    }
}
            
public func ~<Token, A, B, C, D, E, F, G, H, I>(lhs: Parser<Token, I>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H)>) -> Parser<Token, (I, A, B, C, D, E, F, G, H)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (r, rest) in
            return rhs().parse(rest).map(f: { result, t in (r, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7) })
        })
    }
}

public func ~<Token, A, B, C, D, E, F, G, H, I, J>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I)>, rhs: @escaping @autoclosure () -> Parser<Token, J>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (result, rest) in
            return rhs().parse(rest).map(f: { r, t in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, r) })
        })
    }
}
            
public func ~<Token, A, B, C, D, E, F, G, H, I, J>(lhs: Parser<Token, J>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I)>) -> Parser<Token, (J, A, B, C, D, E, F, G, H, I)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (r, rest) in
            return rhs().parse(rest).map(f: { result, t in (r, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8) })
        })
    }
}

public func ~<Token, A, B, C, D, E, F, G, H, I, J, K>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J)>, rhs: @escaping @autoclosure () -> Parser<Token, K>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (result, rest) in
            return rhs().parse(rest).map(f: { r, t in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, r) })
        })
    }
}
            
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K>(lhs: Parser<Token, K>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I, J)>) -> Parser<Token, (K, A, B, C, D, E, F, G, H, I, J)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (r, rest) in
            return rhs().parse(rest).map(f: { result, t in (r, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9) })
        })
    }
}
