// This file is generated via scripts/SequentialOperators.swift. Do not modify manually!

/// Sequential conjunction of two parsers while ignoring the result of lhs
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns the result of rhs
public func >~<Token, A, B>(lhs: Parser<Token, A>, rhs: @escaping @autoclosure () -> Parser<Token, B>) -> Parser<Token, B> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { _, rest in
            return rhs().parse(rest)
        }
    }
}

/// Sequential conjunction of two parsers while ignoring the result of rhs
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns the result of lhs
public func <~<Token, A, B>(lhs: Parser<Token, B>, rhs: @escaping @autoclosure () -> Parser<Token, A>) -> Parser<Token, B> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { result, rest in
            return rhs().parse(rest).map { _, _ in
                return result
            }
        }
    }
}

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B>(lhs: Parser<Token, (A)>, rhs: @escaping @autoclosure () -> Parser<Token, B>) -> Parser<Token, (A, B)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C>(lhs: Parser<Token, (A, B)>, rhs: @escaping @autoclosure () -> Parser<Token, C>) -> Parser<Token, (A, B, C)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C>(lhs: Parser<Token, C>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B)>) -> Parser<Token, (C, A, B)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D>(lhs: Parser<Token, (A, B, C)>, rhs: @escaping @autoclosure () -> Parser<Token, D>) -> Parser<Token, (A, B, C, D)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D>(lhs: Parser<Token, D>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C)>) -> Parser<Token, (D, A, B, C)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E>(lhs: Parser<Token, (A, B, C, D)>, rhs: @escaping @autoclosure () -> Parser<Token, E>) -> Parser<Token, (A, B, C, D, E)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E>(lhs: Parser<Token, E>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D)>) -> Parser<Token, (E, A, B, C, D)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F>(lhs: Parser<Token, (A, B, C, D, E)>, rhs: @escaping @autoclosure () -> Parser<Token, F>) -> Parser<Token, (A, B, C, D, E, F)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F>(lhs: Parser<Token, F>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E)>) -> Parser<Token, (F, A, B, C, D, E)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G>(lhs: Parser<Token, (A, B, C, D, E, F)>, rhs: @escaping @autoclosure () -> Parser<Token, G>) -> Parser<Token, (A, B, C, D, E, F, G)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G>(lhs: Parser<Token, G>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F)>) -> Parser<Token, (G, A, B, C, D, E, F)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H>(lhs: Parser<Token, (A, B, C, D, E, F, G)>, rhs: @escaping @autoclosure () -> Parser<Token, H>) -> Parser<Token, (A, B, C, D, E, F, G, H)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H>(lhs: Parser<Token, H>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G)>) -> Parser<Token, (H, A, B, C, D, E, F, G)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I>(lhs: Parser<Token, (A, B, C, D, E, F, G, H)>, rhs: @escaping @autoclosure () -> Parser<Token, I>) -> Parser<Token, (A, B, C, D, E, F, G, H, I)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I>(lhs: Parser<Token, I>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H)>) -> Parser<Token, (I, A, B, C, D, E, F, G, H)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I)>, rhs: @escaping @autoclosure () -> Parser<Token, J>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J>(lhs: Parser<Token, J>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I)>) -> Parser<Token, (J, A, B, C, D, E, F, G, H, I)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J)>, rhs: @escaping @autoclosure () -> Parser<Token, K>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K>(lhs: Parser<Token, K>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I, J)>) -> Parser<Token, (K, A, B, C, D, E, F, G, H, I, J)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J, K)>, rhs: @escaping @autoclosure () -> Parser<Token, L>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L>(lhs: Parser<Token, L>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K)>) -> Parser<Token, (L, A, B, C, D, E, F, G, H, I, J, K)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L)>, rhs: @escaping @autoclosure () -> Parser<Token, M>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M>(lhs: Parser<Token, M>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L)>) -> Parser<Token, (M, A, B, C, D, E, F, G, H, I, J, K, L)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M)>, rhs: @escaping @autoclosure () -> Parser<Token, N>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N>(lhs: Parser<Token, N>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M)>) -> Parser<Token, (N, A, B, C, D, E, F, G, H, I, J, K, L, M)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N)>, rhs: @escaping @autoclosure () -> Parser<Token, O>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O>(lhs: Parser<Token, O>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N)>) -> Parser<Token, (O, A, B, C, D, E, F, G, H, I, J, K, L, M, N)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O)>, rhs: @escaping @autoclosure () -> Parser<Token, P>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P>(lhs: Parser<Token, P>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O)>) -> Parser<Token, (P, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P)>, rhs: @escaping @autoclosure () -> Parser<Token, Q>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q>(lhs: Parser<Token, Q>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P)>) -> Parser<Token, (Q, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q)>, rhs: @escaping @autoclosure () -> Parser<Token, R>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R>(lhs: Parser<Token, R>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q)>) -> Parser<Token, (R, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R)>, rhs: @escaping @autoclosure () -> Parser<Token, S>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16, result.17, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S>(lhs: Parser<Token, S>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R)>) -> Parser<Token, (S, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16, result.17) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S)>, rhs: @escaping @autoclosure () -> Parser<Token, T>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16, result.17, result.18, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T>(lhs: Parser<Token, T>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S)>) -> Parser<Token, (T, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16, result.17, result.18) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T)>, rhs: @escaping @autoclosure () -> Parser<Token, U>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16, result.17, result.18, result.19, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U>(lhs: Parser<Token, U>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T)>) -> Parser<Token, (U, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16, result.17, result.18, result.19) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U)>, rhs: @escaping @autoclosure () -> Parser<Token, V>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16, result.17, result.18, result.19, result.20, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V>(lhs: Parser<Token, V>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U)>) -> Parser<Token, (V, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16, result.17, result.18, result.19, result.20) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V)>, rhs: @escaping @autoclosure () -> Parser<Token, W>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16, result.17, result.18, result.19, result.20, result.21, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W>(lhs: Parser<Token, W>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V)>) -> Parser<Token, (W, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16, result.17, result.18, result.19, result.20, result.21) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W)>, rhs: @escaping @autoclosure () -> Parser<Token, X>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16, result.17, result.18, result.19, result.20, result.21, result.22, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X>(lhs: Parser<Token, X>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W)>) -> Parser<Token, (X, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16, result.17, result.18, result.19, result.20, result.21, result.22) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X)>, rhs: @escaping @autoclosure () -> Parser<Token, Y>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16, result.17, result.18, result.19, result.20, result.21, result.22, result.23, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y>(lhs: Parser<Token, Y>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X)>) -> Parser<Token, (Y, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16, result.17, result.18, result.19, result.20, result.21, result.22, result.23) }
        }
    }
}
        
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z>(lhs: Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y)>, rhs: @escaping @autoclosure () -> Parser<Token, Z>) -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16, result.17, result.18, result.19, result.20, result.21, result.22, result.23, result.24, res) }
        }
    }
}
    
/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z>(lhs: Parser<Token, Z>, rhs: @escaping @autoclosure () -> Parser<Token, (A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y)>) -> Parser<Token, (Z, A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y)> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, result.0, result.1, result.2, result.3, result.4, result.5, result.6, result.7, result.8, result.9, result.10, result.11, result.12, result.13, result.14, result.15, result.16, result.17, result.18, result.19, result.20, result.21, result.22, result.23, result.24) }
        }
    }
}
        
