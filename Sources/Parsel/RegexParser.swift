//
//  RegexParser.swift
//  ParselPackageDescription
//
//  Created by Benjamin Herzog on 14.08.17.
//

import Foundation

/// A parser that parses Strings with a given regular expression
public final class RegexParser: Parser<String, String> {
    
    /// Possible errors while using RegexParser
    public enum Error: ParseError {
        
        /// Pattern does not match the input (at the beginning)
        ///
        /// - pattern: the pattern that was used
        /// - input: the input that failed on the pattern
        case doesNotMatch(pattern: String, input: String)
        
        /// Regular expression is invalid (could not be evaluated by NSRegularExpression)
        case invalidRegex(String)
    }
    
    /// The pattern of the parser
    public let regex: String
    
    /// Initialize a new RegexParser with a regular expression
    ///
    /// - Parameter regex: the regular expression to use
    public init(_ regex: String) {
        self.regex = regex
        let nsRegex = try? NSRegularExpression(pattern: regex, options: [])
        super.init { str in
            guard let nsRegex = nsRegex else {
                return .fail(Error.invalidRegex(regex))
            }
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
    
    /// Returns a RegexParser with self as the pattern
    public var r: RegexParser {
        return RegexParser(self)
    }
    
}
