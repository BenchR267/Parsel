// # Parser combinators

import Foundation

// create the parser
let addition = L.decimalNumber <~ L.plus ~ L.decimalNumber ^^ (+)

// parse a given input
let result = addition.parse("123+456")

// print out the result
print("result is ", try result.unwrap())
