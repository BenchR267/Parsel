// # Parser combinators

import Foundation

/*:
 
 # parsel
 #### *writing parsers made easy*
 
 *Check out the **documentation*** [**here**](https://benchr267.github.io/parsel/).
 
 ---
 
 A `Parser` in parsel wraps a function of the type `(T) -> ParseResult<T, R>` where `T` is the type that is going to be parsed and `R` is the unprocessed input.
 
 Let's start and declare a simple parser that parses a character:

 */
// Every parsing operation could fail, so we need to provide possible errors
enum ParsingError: ParseError {
    case emptyInput
}

//: The generic parameters of a `Parser` are the type of sequence that is taken as the input and the type that is produced from that input.
let character = Parser<String, Character> { input in
    // since we parse the first character, we need to check if any character is given
    guard let first = input.first else {
        // if not -> we exit early with a failed result
        return .fail(ParsingError.emptyInput)
    }
    // otherwise we can return our result
    return .success(result: first, rest: String(input.dropFirst()))
}
//: At next we need to use our created parser with an input. We try multiple ones, some will succeed, others will fail.
character.parse("abc")
character.parse("")
//: The result of the parse operation is a `ParseResult`. You can use the `unwrap()` and `error()` methods to get the corresponding values, but be careful since they can throw!
try character.parse("abc").unwrap()
try character.parse("").error()
