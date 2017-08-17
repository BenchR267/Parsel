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

public func >~<Token, A, B>(lhs: Parser<Token, A>, rhs: Parser<Token, B>) -> Parser<Token, B> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { _, rest in
            return rhs.parse(rest)
        })
    }
}

public func <~<Token, A, B>(lhs: Parser<Token, B>, rhs: Parser<Token, A>) -> Parser<Token, B> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { result, rest in
            return rhs.parse(rest).map(f: { _, _ in
                return result
            })
        })
    }
}
"""

for i in (1...count) {
    
    let chars = characters(count: i)
    let next = String(character(from: i)).uppercased()
    let resultsArray = (0..<i).map({ "result.\($0)" })
    let results = resultsArray.count > 1 ? resultsArray.joined(separator: ", ") : "result"
    
    string += """


public func ~<Token, \(chars), \(next)>(lhs: Parser<Token, (\(chars))>, rhs: Parser<Token, \(next)>) -> Parser<Token, (\(chars), \(next))> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (result, rest) in
            return rhs.parse(rest).map(f: { r, t in (\(results), r) })
        })
    }
}
    
"""
    
    if i > 1 {
        string += """
        
public func ~<Token, \(chars), \(next)>(lhs: Parser<Token, \(next)>, rhs: Parser<Token, (\(chars))>) -> Parser<Token, (\(next), \(chars))> {
    return Parser { tokens in
        return lhs.parse(tokens).flatMap(f: { (r, rest) in
            return rhs.parse(rest).map(f: { result, t in (r, \(results)) })
        })
    }
}
"""
    }
}



print(string)
