//
//  RegexParser.swift
//  ParserCombinatorPackageDescription
//
//  Created by Benjamin Herzog on 14.08.17.
//

import Foundation

public final class RegexParser: Parser<String, String> {
    
    public enum Error: ParseError {
        case doesNotMatch(pattern: String, input: String)
        case unimplemented
        
        public var code: UInt64 {
            switch self {
            case .doesNotMatch(_): return 0
            case .unimplemented: return 1
            }
        }
    }
    
    public let regex: String
    
    public init(_ regex: String) throws {
        self.regex = regex
        let nsRegex = try NSRegularExpression(pattern: regex, options: [])
        super.init { str in
            let matches = nsRegex.matches(in: str, options: [.anchored], range: NSRange(location: 0, length: str.count))
            guard let first = matches.first else {
                return .fail(Error.doesNotMatch(pattern: regex, input: str))
            }
            
            let end = first.range.location+first.range.length
            let match = String(str.prefix(end))
            return .success(result: match, rest: String(str.dropFirst(end)))
        }
    }
    
}

extension String {
    
    public var r: RegexParser {
        return try! RegexParser(self)
    }
    
}
