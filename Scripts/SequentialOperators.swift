extension Array {
    var second: Element? {
        guard count > 1 else { return nil }
        return self[1]
    }
}

let count = CommandLine.arguments.second.flatMap { Int($0) } ?? 1

if count < 1 {
    fatalError("Count should be 1 or more!")
}

// swiftlint:disable force_unwrapping
func character(from number: Int) -> Character {
    assert(number >= 0)
    assert(number < 26)
    let start = 97
    return Character(UnicodeScalar(number + start)!)
}

func characters(count: Int) -> String {
    let chars = (0..<count).map(character(from:))
                           .map { String($0).uppercased() }
    return chars.joined(separator: ", ")
}

var string = """
// This file is generated via scripts/SequentialOperators.swift. Do not modify manually!

/// Sequential conjunction of two parsers while ignoring the result of lhs
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns the result of rhs
public func ~><Token, A, B>(lhs: Parser<Token, A>, rhs: @escaping @autoclosure () -> Parser<Token, B>) -> Parser<Token, B> {
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

"""

for i in (1...count) {
    
    let chars = characters(count: i)
    let next = String(character(from: i)).uppercased()
    let resultsArray = (0..<i).map({ "result.\($0)" })
    let results = resultsArray.count > 1 ? resultsArray.joined(separator: ", ") : "result"
    
    string += """

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, \(chars), \(next)>(lhs: Parser<Token, (\(chars))>, rhs: @escaping @autoclosure () -> Parser<Token, \(next)>) -> Parser<Token, (\(chars), \(next))> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (result, rest) in
            return rhs().parse(rest).map { res, _ in (\(results), res) }
        }
    }
}
    
"""
    
    if i > 1 {
        string += """

/// Sequential conjunction of lhs and rhs with combining of the results in a tuple
///
/// - Parameters:
///   - lhs: the first parser that has to succeed
///   - rhs: the second parser that has to succeed
/// - Returns: a parser that parses lhs, then rhs on the rest and returns a tuple of the combined results
public func ~<Token, \(chars), \(next)>(lhs: Parser<Token, \(next)>, rhs: @escaping @autoclosure () -> Parser<Token, (\(chars))>) -> Parser<Token, (\(next), \(chars))> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap { (res, rest) in
            return rhs().parse(rest).map { result, _ in (res, \(results)) }
        }
    }
}
        
"""
    }
}

print(string)
