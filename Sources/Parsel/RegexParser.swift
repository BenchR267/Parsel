//
//  RegexParser.swift
//  ParselPackageDescription
//
//  Created by Benjamin Herzog on 14.08.17.
//

import Foundation

/// A shortcut to RegexParser
public typealias Regex = RegexParser

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
 
    // MARK: - Common used regular expressions
    // (thanks to https://code.tutsplus.com/tutorials/8-regular-expressions-you-should-know--net-6149)
    
    /// Parses an e-mail-address
    public static let mail = "([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})".r
    
    /// Parses an http(s) address
    public static let httpAddress = "(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?".r
    
    /// Parses an IP address
    public static let ipAddress = "(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)".r
    
    /// Parses a semantic version number (1.0.0, 1.0, …) thanks to https://github.com/mojombo/semver/issues/232
    public static let semver = "(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(-(0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(\\.(0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*)?(\\+[0-9a-zA-Z-]+(\\.[0-9a-zA-Z-]+)*)?".r
}

extension String {
    
    /// Returns a RegexParser with self as the pattern
    public var r: RegexParser {
        return RegexParser(self)
    }
    
}
