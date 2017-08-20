# ParserCombinator 
![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg) [![Build Status](https://travis-ci.org/BenchR267/ParserCombinator.svg?branch=master)](https://travis-ci.org/BenchR267/ParserCombinator) [![CocoaPods](https://img.shields.io/cocoapods/v/SwiftParserCombinator.svg)]() [![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org) [![](https://img.shields.io/badge/documentation-available-brightgreen.svg)](https://benchr267.github.io/ParserCombinator/)

ParserCombinator is a WIP library that enables you to write parsers for a given grammer as easy as possible. Take for example a parser that is able to parse addition of two numbers:

```Swift
let digit: Parser<String, Int> = …

func char(_ c: Character) -> Parser<String, Character> {
    return …
}

let addition = (digit ~ char("+") ~ digit).map { a, _, b in
    return a + b
}
let result = addition.parse("2+4")

try! result.unwrap() // Int: 6
```

# Why should I use this?

Parsing is a very common task, it does not always mean to parse source code or JSON strings. Parsing means to transform an unstructured input to a structured output. In case of source code this means to parse a raw string to an AST (abstract syntax tree), in case of an addition it means to parse the result of adding two numbers out of a string.
Parsing can always fail, if the input does not match the needed grammer. If the input string in the above example would have been `1+`, it would have been failed because the second number is missing.
The advantage of parser combinators is that you start with a very basic parser. In the above example `digit` parses only one digit. But it is not hard, to add a parser that parses more than one digit. A number is a repetition of mulitple digits. For repetition, we can use `rep`, which tries to apply the parser until it fails and collects the result as an array.
Parsing an integer addition is as easy as

```Swift
func intFromDigits(_ digits: [Int]) -> Int {
    return digits.reduce(0) { res, e in    
        return res * 10 + e
    }
}

let number = digit.rep.map(intFromDigits)
let addition = (number ~ char("+") ~ number).map { a, _, b in
    return a + b
}

let result = addition.parse("123+456")
try! result.unwrap() // Int: 579
```

# What are the disadvantages?

Since parser combinators are very high level, they abstract the whole process of parsing a lot. That means it is easier to use but it also means that the performance is not as good as an optimized, handwritten parser.

# Installation

ParserCombinator is currently available via Swift Package Manager and Cocoapods. Support for Carthage will come later.

## Swift Package Manager

To use it in your project, just add it as a dependency in your `Package.swift` file and run `swift package update`.

```Swift
import PackageDescription

let package = Package(
  name: "MyAwesomeApp",
  dependencies: [
    .package(url: "https://github.com/BenchR267/ParserCombinator", from: "1.0.0")
  ]
)
```

## Cocoapods

To use ParserCombinator with Cocoapods, just add this entry to your Podfile and run `pod install`: (due to naming collisions, the pods name is different)

```Ruby
target 'MyAwesomeApp' do
  use_frameworks!

  pod 'SwiftParserCombinator'
end
```

# Requirements

* Swift 4.0
    * ParserCombinator is written in Swift 4.0 development snapshots and will be available when Swift 4.0 is released

# Example

[Calculator](https://github.com/BenchR267/Calculator) is a small example I wrote with ParserCombinator.

![Calculator_GIF](https://github.com/BenchR267/Calculator/raw/master/doc/img/Calculator.gif)

# Documentation

Check out the documentation on the [Github page](https://benchr267.github.io/ParserCombinator/).

# Author

* [@benchr](https://twitter.com/benchr), mail@benchr.de

# License

ParserCombinator is under MIT license. See the LICENSE file for more info.
