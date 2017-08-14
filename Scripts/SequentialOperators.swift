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
    
}

print(string)
