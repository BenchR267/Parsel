//
//  RegexParser.swift
//  ParselPackageDescription
//
//  Created by Benjamin Herzog on 14.08.17.
//

import Foundation

// swiftlint:disable type_name
/// A shortcut to RegexParser
public typealias R = RegexParser

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
    public static let mail = """
([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})
""".r
    
    // swiftlint:disable line_length
    /// Parses an http(s) address
    public static let httpAddress = """
^(?i)(?:(?:https?|ftp):\\/\\/)?(?:\\S+(?::\\S*)?@)?(?:(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}(?:\\.(?:[1-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))|(?:(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)(?:\\.(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)*(?:\\.(?:[a-z\\u00a1-\\uffff]{2,})))(?::\\d{2,5})?(?:\\/[^\\s]*)?$
""".r
    
    /// Parses an IP address
    public static let ipAddress = """
(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)
""".r

    /// Parses a semantic version number (1.0.0, 1.0, …) thanks to https://git.daplie.com/coolaj86/semver-utils
    public static let semver = """
v?((\\d+)\\.(\\d+)\\.(\\d+))(?:-([\\dA-Za-z\\-]+(?:\\.[\\dA-Za-z\\-]+)*))?(?:\\+([\\dA-Za-z\\-]+(?:\\.[\\dA-Za-z\\-]+)*))?
""".r
}

extension String {

    // swiftlint:disable identifier_name
    /// Returns a RegexParser with self as the pattern
    public var r: RegexParser {
        return RegexParser(self)
    }
    
}
