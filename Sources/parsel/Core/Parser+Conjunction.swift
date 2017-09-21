//
//  Parser+Conjunction.swift
//  Parsel
//
//  Created by Benjamin Herzog on 13.08.17.
//

extension Parser {

    /// Discards the result of self and executes other afterwards on the rest.
    ///
    /// - Parameter other: another parser to execute afterwards
    /// - Returns: a parser that first parses self and then other on the rest of self
    public func then<B>(_ other: @escaping @autoclosure () -> Parser<T, B>) -> Parser<T, B> {
        return self.flatMap { _ in other() }
    }

    /// Erases the type of the parser
    public var typeErased: Parser<T, ()> {
        return Parser<T, ()> { tokens in
            switch self.parse(tokens) {
            case let .success(_, rest):
                return .success(result: (), rest: rest)
            case let .fail(err):
                return .fail(err)
            }
            
        }
    }
    
    /// Tries to parse self and consumes it if success.
    /// If self fails, the parser still succeeds and consumes nothing.
    public var optional: Parser<T, R?> {
        return (self ^^ { $0 }) | Parser.just(nil)
    }
    
    // MARK: - OR
    
    /// Concatenates the results of both parsers.
    ///
    /// - Parameter other: another parser which results should be added
    /// - Returns: a parser that contains both parsing results.
    public func or(_ other: @escaping @autoclosure () -> Parser<T, R>) -> Parser<T, R> {
        return Parser { tokens in
            let result = self.parse(tokens)
            switch result {
            case .fail:
                return other().parse(tokens)
            default:
                return result
            }
        }
    }

    /// Concatenates the results of self + all given parsers.
    /// The first of all that succeedes will be used.
    ///
    /// - Parameter others: a sequence of parsers to use as fallback
    /// - Returns: a parser that tries all concatenates parsers in order
    public func or<S: Sequence>(_ others: @escaping @autoclosure () -> S) -> Parser<T, R> where S.Element == Parser<T, R> {
        return Parser { tokens in
            let result = self.parse(tokens)
            switch result {
            case let .success(result, rest):
                return .success(result: result, rest: rest)
            case let .fail(err):
                for parser in others() {
                    if case let .success(result, rest) = parser.parse(tokens) {
                        return .success(result: result, rest: rest)
                    }
                }
                return .fail(err) // the first error will be returned
            }
        }
    }
    
    /// Concatenates the results of given parsers with an or operation.
    /// Will parse Errors.conjunctionOfEmptyCollection if given collection is empty!
    ///
    /// - Parameter parsers: the parsers to combine
    /// - Returns: a parser that tries to parse the given parsers in order until one succeeds
    public static func or<C: Collection>(_ parsers: C) -> Parser<T, R> where C.Element == Parser<T, R> {
        guard let first = parsers.first else {
            return Parser { _ in .fail(Errors.conjunctionOfEmptyCollection) }
        }
        return first.or(parsers.dropFirst())
    }
    
    // MARK: - fallback
    
    /// Provides a fallback if the parser fails.
    ///
    /// - Parameter defaultValue: a value that should be parsed instead.
    /// - Returns: a parser that tries to parse and uses defaultValue if parsing failed.
    ///
    /// *NOTE* If parsing fails, there are no tokens consumed!
    public func fallback(_ defaultValue: @escaping @autoclosure () -> R) -> Parser<T, R> {
        return Parser { tokens in
            let result = self.parse(tokens)
            switch result {
            case .fail:
                return .success(result: defaultValue(), rest: tokens)
            default:
                return result
            }
        }
    }
    
    /// Provides a fallback parser that is being used if self.parse fails.
    ///
    /// - Parameter defaultValue: the parser to use in case of failure
    /// - Returns: a parser that first tries self.parse and only uses defaultValue if self failed.
    public func fallback(_ defaultValue: @escaping @autoclosure () -> Parser<T, R>) -> Parser<T, R> {
        return Parser { tokens in
            switch self.parse(tokens) {
            case let .success(result, rest):
                return .success(result: result, rest: rest)
            default:
                return defaultValue().parse(tokens)
            }
        }
    }
    
    // MARK: - repetition
    
    /// Parses self repetitive with at least one success
    public var atLeastOnce: Parser<T, [R]> {
        return (self ~ self.rep) ^^ { [$0] + $1 }
    }
    
    /// Parses self repetitive with separator with at least one success
    ///
    /// - Parameter sep: separator to use between parse operations
    /// - Returns: a parser that parses self repetitive with separator with at least one success.
    public func atLeastOnce<B>(sep: Parser<T, B>) -> Parser<T, [R]> {
        return self.rep(sep: sep).flatMap({ res in
            if res.isEmpty {
                return Parser<T, [R]>.fail(error: Errors.expectedAtLeastOnce)
            }
            return Parser.just(res)
        })
    }
    
    /// Parses self repetitive with at least `count` succeeds.
    ///
    /// - Parameter count: the number of required succeeds
    /// - Returns: a parser that parses self repetitive with at least `count` succeeds
    public func atLeast(count: Int) -> Parser<T, [R]> {
        return self.rep.filter({ parsed in
            guard parsed.count >= count else {
                return Errors.expectedAtLeast(count, got: parsed.count)
            }
            return nil
        })
    }
    
    /// Parses self exactly count times and return the results in an array
    ///
    /// - Parameter count: the count how often self should be parsed
    /// - Returns: a parser that tries to parse self exactly count times
    public func exactly(count: Int) -> Parser<T, [R]> {
        precondition(count > 0)
        if count == 1 {
            return self ^^ { [$0] }
        }
        return (self ~ self.exactly(count: count - 1)) ^^ { [$0] + $1 }
    }
    
    /// Parses self repetitive and returns results in array
    public var rep: Parser<T, [R]> {
        return Parser<T, [R]> { tokens in
            var results = [R]()
            var totalRest = tokens

            loop: while true {
                switch self.parse(totalRest) {
                case let .success(result, rest):
                    results.append(result)
                    totalRest = rest
                case .fail:
                    break loop
                }
            }

            return .success(result: results, rest: totalRest)
        }
    }
    
    /// Parses self repetitive separated by sep Parser.
    ///
    /// - Parameter sep: the parser that separates self.parse operations.
    /// - Returns: a parser that parses self separated by sep as long as it doesn't fail.
    public func rep<B>(sep: Parser<T, B>) -> Parser<T, [R]> {
        return Parser<T, [R]> { tokens in
            var results = [R]()
            var totalRest = tokens
            
            let both = self <~ sep
            
            loop: while true {
                
                switch both.parse(totalRest) {
                case let .success(result, rest):
                    results.append(result)
                    totalRest = rest
                case .fail:
                    switch self.parse(totalRest) {
                    case let .success(singleResult, singleRest):
                        results.append(singleResult)
                        totalRest = singleRest
                        break loop
                    case .fail:
                        return .success(result: results, rest: totalRest)
                    }
                }
                
            }
            
            return .success(result: results, rest: totalRest)
        }
    }
    
}
