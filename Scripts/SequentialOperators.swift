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

func characters(count: Int, prefix: String = "", uppercased: Bool = true) -> String {
    let chars = (0..<count).map(character(from:))
                           .map { prefix + (uppercased ? String($0).uppercased() : String($0)) }
    return chars.joined(separator: ", ")
}

var string = """
// This file is generated via scripts/SequentialOperators.swift. Do not modify manually!
"""

for i in (1...count) {
    
    let chars = characters(count: i)
    let next = String(character(from: i)).uppercased()
    let results = characters(count: i, prefix: "result")
    
    string += """


public func ~<Token, \(chars), \(next)>(lhs: Parser<Token, (\(chars))>, rhs: Parser<Token, \(next)>) -> Parser<Token, (\(chars), \(next))> {
    return Parser { tokens in
        switch lhs.parse(tokens) {
        case let .success((\(results)), rest):
            return rhs.parse(rest).map(f: { (\(results), $0) })
        case let .fail(err):
            return .fail(err)
        }
    }
}
"""
    
}

print(string)
